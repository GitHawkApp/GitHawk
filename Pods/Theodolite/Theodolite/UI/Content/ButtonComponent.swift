//
//  ButtonComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 12/28/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public class ButtonComponent: Component, TypedComponent {
  
  public typealias StateMap<V> = [UIControlState: V]
  
  public struct Options {
    /** The actions for the button when it transitions to a state. */
    let actions: [UIControlEvents:[Action<UIButton>]]?
    /** The title of the button for different states. */
    let titles: StateMap<String>?
    /** The title colors of the button for different states. */
    let titleColors: StateMap<UIColor>?
    /** The images of the button for different states. */
    let images: StateMap<UIImage>?
    /** The background images of the button for different states. */
    let backgroundImages: StateMap<UIImage>?
    /** The title font the button. */
    let titleFont: UIFont?
    /** Wether the button is selected. */
    let selected: Bool?
    /** Wether the button is enabled. */
    let enabled: Bool?
    /** Content insets for the label inside the button. */
    let contentEdgeInsets: UIEdgeInsets?
    /** Additional attributes for the underlying UIBUtton. */
    let attributes: [Attribute]?
    
    init(
      actions: [UIControlEvents:[Action<UIButton>]]? = nil,
      titles: StateMap<String>? = nil,
      titleColors: StateMap<UIColor>? = nil,
      images: StateMap<UIImage>? = nil,
      backgroundImages: StateMap<UIImage>? = nil,
      titleFont: UIFont? = nil,
      selected: Bool? = nil,
      enabled: Bool? = nil,
      contentEdgeInsets: UIEdgeInsets? = nil,
      attributes: [Attribute]? = nil
      ) {
      self.actions = actions
      self.titles = titles
      self.titleColors = titleColors
      self.images = images
      self.backgroundImages = backgroundImages
      self.titleFont = titleFont
      self.selected = selected
      self.enabled = enabled
      self.contentEdgeInsets = contentEdgeInsets
      self.attributes = attributes
    }
  };

  public typealias PropType = Options
  
  var actionController: ActionController? = nil
  
  public override func componentDidMount() {
    let ac: ActionController
    // Lazily create the action controller. Not really necessary, but nice to avoid the work until
    // someone actually mounts.
    if let actionController = self.actionController  {
      ac = actionController
    } else {
      ac = ActionController(actions: props.actions ?? [:])
      self.actionController = ac
    }
    if let button = context.mountInfo.currentView as? UIButton {
      // Note that we do not detach in unmount. The idea is to leave the action controller attached
      // between mount/unmount phases so we don't needlessly churn UIButton.
      ac.attach(button: button)
    }
  }
  
  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    let size = intrinsicSize(title: (props.titles?[.normal] ?? "") as NSString,
                             titleFont: props.titleFont,
                             image: props.images?[.normal],
                             backgroundImage: props.backgroundImages?[.normal],
                             contentEdgeInsets: props.contentEdgeInsets ?? UIEdgeInsets.zero)
    return Layout(component: self,
                  size: constraint.clamp(
                    CGSize(
                      width: ceil(size.width),
                      height: ceil(size.height))),
                  children: [])
  }
  
  private func intrinsicSize(title: NSString,
                             titleFont: UIFont?,
                             image: UIImage?,
                             backgroundImage: UIImage?,
                             contentEdgeInsets: UIEdgeInsets) -> CGSize
  {
    // This computation is based on observing [UIButton -sizeThatFits:], which uses the deprecated method
    // sizeWithFont in iOS 7 and iOS 8
    let titleSize = title.size(withAttributes: [.font: titleFont ?? UIFont.systemFont(ofSize: UIFont.buttonFontSize)])
    let imageSize = image?.size ?? CGSize.zero
    let contentSize = CGSize(width: titleSize.width + imageSize.width + contentEdgeInsets.left + contentEdgeInsets.right,
                             height: max(titleSize.height, imageSize.height) + contentEdgeInsets.top + contentEdgeInsets.bottom)
    let backgroundImageSize = backgroundImage?.size ?? CGSize.zero
    return CGSize(
      width: max(backgroundImageSize.width, contentSize.width),
      height: max(backgroundImageSize.height, contentSize.height))
  }
  
  public override func view() -> ViewConfiguration? {
    var attributes = props.attributes ?? []
    if let titles = props.titles {
      attributes.append(Attr(ObjectIdentifier(self), identifier: "theodolite-buttonTitles")
      {(button: UIButton, _) in
        // Note that we have to enumerate over *all* states here, because we have to make sure
        // that on re-use we have un-set all the values that previous owners of this button
        // have configured.
        self.enumerateAllStates(block: { (state) in
          button.setTitle(titles[state], for: state)
        })
      })
    }
    if let titleColors = props.titleColors {
      attributes.append(Attr(ObjectIdentifier(self), identifier: "theodolite-buttonTitleColors")
      {(button: UIButton, _) in
        self.enumerateAllStates(block: { (state) in
          button.setTitleColor(titleColors[state], for: state)
        })
      })
    }
    if let images = props.images {
      attributes.append(Attr(ObjectIdentifier(self), identifier: "theodolite-buttonImages")
      {(button: UIButton, _) in
        self.enumerateAllStates(block: { (state) in
          button.setImage(images[state], for: state)
        })
      })
    }
    if let backgroundImages = props.backgroundImages {
      attributes.append(Attr(ObjectIdentifier(self), identifier: "theodolite-buttonBackgroundImages")
      {(button: UIButton, _) in
        self.enumerateAllStates(block: { (state) in
          button.setBackgroundImage(backgroundImages[state], for: state)
        })
      })
    }
    if let titleFont = props.titleFont {
      attributes.append(Attr(titleFont, identifier: "theodolite-buttonTitleFont")
      {(button: UIButton, font: UIFont) in
        button.titleLabel?.font = font
      })
    }
    if let selected = props.selected {
      attributes.append(Attr(selected, identifier: "theodolite-buttonSelected")
      {(button: UIButton, selected: Bool) in
        button.isSelected = selected
      })
    }
    if let enabled = props.enabled {
      attributes.append(Attr(enabled, identifier: "theodolite-buttonEnabled")
      {(button: UIButton, enabled: Bool) in
        button.isEnabled = enabled
      })
    }
    return ViewConfiguration(view: UIButton.self, attributes: attributes)
  }
  
  /**
   Note this only enumerates through the default UIControlStates, not any application-defined or system-reserved ones.
   It excludes any states with both UIControlStateHighlighted and UIControlStateDisabled set as that is an invalid value.
   (UIButton will, surprisingly enough, throw away one of the bits if they are set together instead of ignoring it.)
   */
  private func enumerateAllStates(block: (UIControlState) -> ()) {
    for highlighted in 0 ..< 2 {
      for disabled in 0 ..< 2 {
        for selected in 0 ..< 2 {
          let state =
            UIControlState(rawValue:
              (highlighted == 1 ? UIControlState.highlighted.rawValue : UInt(0))
                | (disabled == 1 ? UIControlState.disabled.rawValue : UInt(0))
                | (selected == 1 ? UIControlState.selected.rawValue : UInt(0)))
          if ((state.rawValue & UIControlState.highlighted.rawValue != 0)
            && (state.rawValue & UIControlState.disabled.rawValue != 0)) {
            continue;
          }
          block(state)
        }
      }
    }
  }
  
  class ActionController {
    let containers: [UIControlEvents: ActionContainer]
    
    init(actions: [UIControlEvents: [Action<UIButton>]]) {
      var c: [UIControlEvents: ActionContainer] = [:]
      for (event, actionArray) in actions {
        c[event] = ActionContainer(actionArray)
      }
      containers = c
    }
    
    func attach(button: UIButton) {
      let attachedController: ActionController? = getAssociatedObject(object: button, associativeKey: &kActionControllerKey)
      if attachedController === self {
        // We're already attached, no point in attaching
        return
      } else if let controller = attachedController {
        // A different action controller is attached. We should detach it before we attach.
        controller.detach(button: button)
      }
      for (event, container) in containers {
        container.attach(button: button, controlEvent: event)
      }
      setAssociatedObject(object: button, value: self, associativeKey: &kActionControllerKey)
    }
    
    func detach(button: UIButton) {
      for (event, container) in containers {
        container.detach(button: button, controlEvent: event)
      }
    }
  }

  class ActionContainer {
    let actions: [Action<UIButton>]
    
    init (_ actions: [Action<UIButton>]) {
      self.actions = actions
    }
    
    func attach(button: UIButton, controlEvent: UIControlEvents) {
      button.addTarget(self, action: #selector(ActionContainer.send), for: controlEvent)
    }
    
    func detach(button: UIButton, controlEvent: UIControlEvents) {
      button.removeTarget(self, action: #selector(ActionContainer.send), for: controlEvent)
    }
    
    @objc func send(sender: UIButton) {
      for action in actions {
        action.send(sender)
      }
    }
  }
}

var kActionControllerKey: Void?

/** Required for the UIControlState:value mapping. */
extension UIControlState: Hashable {
  public var hashValue: Int {
    get { return Int(self.rawValue) }
  }
}

/** Required for the UIControlState:value mapping. */
extension UIControlEvents: Hashable {
  public var hashValue: Int {
    get { return Int(self.rawValue) }
  }
}
