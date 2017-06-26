//
//  SwipeCollectionViewCellDelegate.swift
//
//  Created by Jeremy Koch
//  Copyright © 2017 Jeremy Koch. All rights reserved.
//

import UIKit

/**
 The `SwipeCollectionViewCellDelegate` protocol is adopted by an object that manages the display of action buttons when the cell is swiped.
 */
public protocol SwipeCollectionViewCellDelegate: class {
    /**
     Asks the delegate for the actions to display in response to a swipe in the specified row.

     - parameter collectionView: The table view object which owns the cell requesting this information.

     - parameter indexPath: The index path of the row.

     - parameter orientation: The side of the cell requesting this information.

     - returns: An array of `SwipeAction` objects representing the actions for the row. Each action you provide is used to create a button that the user can tap.  Returning `nil` will prevent swiping for the supplied orientation.
     */
    func collectionView(_ collectionView: UICollectionView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]?

    /**
     Asks the delegate for the display options to be used while presenting the action buttons.

     - parameter collectionView: The table view object which owns the cell requesting this information.

     - parameter indexPath: The index path of the row.

     - parameter orientation: The side of the cell requesting this information.

     - returns: A `SwipeTableOptions` instance which configures the behavior of the action buttons.

     - note: If not implemented, a default `SwipeTableOptions` instance is used.
     */
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions

    /**
     Tells the delegate that the table view is about to go into editing mode.

     - parameter collectionView: The table view object providing this information.

     - parameter indexPath: The index path of the row.

     - parameter orientation: The side of the cell.
     */
    func collectionView(_ collectionView: UICollectionView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation)

    /**
     Tells the delegate that the table view has left editing mode.

     - parameter collectionView: The table view object providing this information.

     - parameter indexPath: The index path of the row.

     - parameter orientation: The side of the cell.
     */
    func collectionView(_ collectionView: UICollectionView, didEndEditingRowAt indexPath: IndexPath?, for orientation: SwipeActionsOrientation)
}

/**
 Default implementation of `SwipecollectionViewCellDelegate` methods
 */
public extension SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        return SwipeTableOptions()
    }

    func collectionView(_ collectionView: UICollectionView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {}

    func collectionView(_ collectionView: UICollectionView, didEndEditingRowAt indexPath: IndexPath?, for orientation: SwipeActionsOrientation) {}
}
