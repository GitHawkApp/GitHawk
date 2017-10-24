//
//  DeleteSwipeAction.swift
//  Freetime
//
//  Created by Hesham Salman on 10/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import SwipeCellKit

func DeleteSwipeAction(callback: ((SwipeAction, IndexPath) -> Void)? = nil) -> SwipeAction {
    let action = SwipeAction(style: .destructive, title: Constants.Strings.delete, handler: callback)

    action.image = #imageLiteral(resourceName: "trashcan").withRenderingMode(.alwaysTemplate)
    action.backgroundColor = Styles.Colors.Red.medium.color
    action.textColor = .white
    action.tintColor = .white

    return action
}
