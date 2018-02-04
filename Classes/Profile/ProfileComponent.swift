//
//  ProfileComponent.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Theodolite
import Flexbox

/**

 +------------------------+
 | +------+               |
 | |      |  Username     |
 | |      |  Full Name    |
 | |      |  Bio          |
 | +------+               |
 +------------------------+

 */
final class ProfileComponent: Component, TypedComponent {
  typealias PropType = (ProfileResult)

  override func render() -> [Component] {
    let options = LabelComponent.Options(
      view: ViewOptions(backgroundColor: .white),
      font: UIFont(name: "Courier", size: 12)!)
    var verticalChildren: [FlexChild] = [
      FlexChild(LabelComponent(("⚙️ \(self.props.id)", options))),
      FlexChild(LabelComponent(("🔑 \(self.props.login)", options))),
    ]
    if let name = self.props.name {
      verticalChildren.append(FlexChild(LabelComponent(("👤 \(name)", options))))
    }
    if let location = self.props.location {
      verticalChildren.append(FlexChild(LabelComponent(("📍 \(location)", options))))
    }
    if let bio = self.props.bio {
      verticalChildren.append(FlexChild(LabelComponent(("📖 \(bio)", options))))
    }


    var horizontalChildren: [FlexChild] = []

    if let url = self.props.avatarUrl,
      let data = try? Data(contentsOf: url),
      let image = UIImage(data: data) {
      horizontalChildren.append(FlexChild(
        ImageComponent((
          image,
          size: CGSize(width: 100, height: 100),
          options: ViewOptions())),
        margin: Edges(right: 10))
      )
    }

    horizontalChildren.append(FlexChild(FlexboxComponent((
      options: FlexOptions(flexDirection: .column),
      children: verticalChildren))))

    return [FlexboxComponent((
      options: FlexOptions(
        flexDirection: .row,
        justifyContent: .flexStart,
        alignItems: .flexStart,
        alignContent: .flexStart
      ),
      children: horizontalChildren))]
  }

}

