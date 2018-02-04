//
//  File.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Theodolite

final class ProfileViewController: UIViewController {
  let client: GithubClient

  lazy var hostingView: ComponentHostingView = {
    return ComponentHostingView { [weak self] in
      guard let client = self?.client else {
        fatalError("ooops")
      }
      return ProfileLoadingComponent((client))
    }
  }()
  
  init(client: GithubClient) {
    self.client = client
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(hostingView)
    hostingView.frame = view.bounds.insetBy(dx: 0, dy: 100)
    hostingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
