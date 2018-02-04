//
//  ProfileComponent.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Theodolite

enum State {
  case idle
  case loading
  case failed(error: Error)
  case succeeded(ProfileResult)
}

final class ProfileLoadingComponent: Component, TypedComponent {
  typealias PropType = (GithubClient)

  typealias StateType = State

  override func render() -> [Component] {
    let component: Component
    let options = LabelComponent.Options(view: ViewOptions(backgroundColor: .red), textAlignment: .center)
    switch self.state ?? State.idle {
    case .idle:
      component = LabelComponent(("Idle", options))
      startFetchingProfile()
    case .loading:
      component = LabelComponent(("Loading", options))
    case let .failed(error):
      component = LabelComponent(("Failed", options))
    case let .succeeded(profile):
      component = ProfileComponent((profile))
    }
    return [
      FlexboxComponent((
        options: FlexOptions(flexDirection: .column),
        children: [FlexChild(component)]
      ))
    ]
  }

  private func startFetchingProfile() {
    self.updateState(state: .loading)
    self.props.fetchProfile { (result) in
      switch result {
      case let .error(error):
        self.updateState(state: .failed(error: error ?? NSError()))
      case let .success(profile):
        self.updateState(state: .succeeded(profile))
      }
    }
  }
}
