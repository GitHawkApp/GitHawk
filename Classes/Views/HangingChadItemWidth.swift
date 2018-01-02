//
//  HangingChadItemWidth.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

func HangingChadItemWidth(
    index: Int,
    count: Int,
    containerWidth: CGFloat,
    desiredItemWidth: CGFloat
    ) -> CGFloat {
    guard count > 0, index < count else { return 0 }

    let maxPerRow = Int(floor(containerWidth / desiredItemWidth))
    let itemsPerRow = min(count, maxPerRow)

    let fullRows = count / itemsPerRow
    let fullRowsCount = fullRows * itemsPerRow
    let remainder = count - fullRowsCount

    let itemsInThisRow: Int
    if remainder == 1 && count > 2 && itemsPerRow > 1 {
        let row = index / itemsPerRow
        if row == fullRows {
            itemsInThisRow = 2
        } else if row == fullRows - 1 {
            if index == count - 2 {
                itemsInThisRow = 2
            } else {
                itemsInThisRow = itemsPerRow - 1
            }
        } else {
            itemsInThisRow = itemsPerRow
        }
    } else if index > fullRowsCount - 1 {
        itemsInThisRow = remainder
    } else {
        itemsInThisRow = itemsPerRow
    }

    return floor(containerWidth / CGFloat(itemsInThisRow))
}
