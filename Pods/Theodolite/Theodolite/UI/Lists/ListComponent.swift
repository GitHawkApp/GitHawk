//
//  ListComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 11/18/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation
import Flexbox

public struct ListBatch<ItemType> {
  let before: AnyHashable
  let after: AnyHashable
  let items: [ItemType]

  public init(before: AnyHashable, after: AnyHashable, items: [ItemType]) {
    self.before = before
    self.after = after
    self.items = items
  }
}

public struct ListFetchError: Error {
  let string: String
  public init(string: String) {
    self.string = string
  }
}

public enum ListFetchStatus<ItemType> {
  case success(batch: ListBatch<ItemType>)
  case error(e: Error)
}

public typealias ListItemSource<ItemType> = (
  _ before: AnyHashable?,
  _ after: AnyHashable?,
  _ handler: @escaping (ListFetchStatus<ItemType>) -> ()
) -> ()

public final class ListComponent<ItemType>: Component, TypedComponent {
  public struct Options {
    let flexOptions: FlexOptions
    let childMargin: Edges
    let source: ListItemSource<ItemType>
    let factory: (ItemType) -> Component
    let loadHead: Trigger<Void?>
    let loadTail: Trigger<Void?>

    public init(flexOptions: FlexOptions,
                childMargin: Edges,
                source: @escaping ListItemSource<ItemType>,
                factory: @escaping (ItemType) -> Component,
                loadHead: Trigger<Void?>,
                loadTail: Trigger<Void?>) {
      self.flexOptions = flexOptions
      self.childMargin = childMargin
      self.source = source
      self.factory = factory
      self.loadHead = loadHead
      self.loadTail = loadTail
    }
  }
  public typealias PropType = Options
  public typealias StateType = [ListBatch<ItemType>]

  private var initiatedFetch: Bool = false

  public override func render() -> [Component] {
    props.loadHead.resolve(Handler(self, ListComponent.loadHead))
    props.loadTail.resolve(Handler(self, ListComponent.loadTail))
    guard let batches = state else {
      return []
    }
    return [
      FlexboxComponent(
        (options: props.flexOptions,
         children: batches.flatMap({ (batch) -> FlexChild? in
          return FlexChild(
            FlexboxComponent(
              key: batch.before,
              (options: props.flexOptions,
               children:batch.items.flatMap({ (item) -> FlexChild? in
                return FlexChild(props.factory(item), margin: props.childMargin)
               }))
          ))
         })
      ))
    ]
  }
  
  public override func componentDidMount() {
    super.componentDidMount()
    if state == nil && !initiatedFetch {
      self.loadHead(nil)
    }
  }

  func loadHead(_: Void?) {
    if initiatedFetch {
      return
    }
    self.initiatedFetch = true
    props.source(nil, nil, { (status) in
      switch status {
      case .success(let batch):
        self.updateState(state: [batch])
        break
      case .error(let e):
        print("Error loading initial list data:\(e)")
        self.initiatedFetch = false
        break
      }
    })
  }

  func loadTail(_: Void?) {
    if initiatedFetch {
      return
    }
    self.initiatedFetch = true
    props.source(nil, state?.last?.after, { (status) in
      switch status {
      case .success(let batch):
        var newState = self.state ?? []
        newState.append(batch)
        self.updateState(state: newState)
        break
      case .error(let e):
        print("Error loading initial list data:\(e)")
        self.initiatedFetch = false
        break
      }
    })
  }
}
