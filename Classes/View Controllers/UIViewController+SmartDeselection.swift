//
//  UIViewController+SmartDeselection.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

// https://www.raizlabs.com/dev/2016/05/smarter-animated-row-deselection-ios/
extension UIViewController {

    func rz_smoothlyDeselectRows(tableView: UITableView?) {
        // if part of a split VC and "full screen" in the primary spot, dont deselect
        // also consider if embedded in nav VC
        if let split = splitViewController,
            let first = split.viewControllers.first,
            (first === self || first === navigationController) && split.isCollapsed == false {
            return
        }

        // Get the initially selected index paths, if any
        let selectedIndexPaths = tableView?.indexPathsForSelectedRows ?? []

        // Grab the transition coordinator responsible for the current transition
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { context in
                // Deselect the cells, with animations enabled if this is an animated transition
                selectedIndexPaths.forEach {
                    tableView?.deselectRow(at: $0, animated: context.isAnimated)
                }
            }, completion: { context in
                // If the transition was cancel, reselect the rows that were selected before,
                // so they are still selected the next time the same animation is triggered
                if context.isCancelled {
                    selectedIndexPaths.forEach {
                        tableView?.selectRow(at: $0, animated: context.isAnimated, scrollPosition: .none)
                    }
                }
            })
        }
    }


    func rz_smoothlyDeselectRows(collectionView: UICollectionView?) {
        // if part of a split VC and "full screen" in the primary spot, dont deselect
        // also consider if embedded in nav VC
        if let split = splitViewController,
            let first = split.viewControllers.first,
            (first === self || first === navigationController) && split.isCollapsed == false {
            return
        }

        // Get the initially selected index paths, if any
        let selectedIndexPaths = collectionView?.indexPathsForSelectedItems ?? []

        // Grab the transition coordinator responsible for the current transition
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { context in
                // Deselect the cells, with animations enabled if this is an animated transition
                selectedIndexPaths.forEach {
                    collectionView?.deselectItem(at: $0, animated: context.isAnimated)
                }
            }, completion: { context in
                // If the transition was cancel, reselect the rows that were selected before,
                // so they are still selected the next time the same animation is triggered
                if context.isCancelled {
                    selectedIndexPaths.forEach {
                        collectionView?.selectItem(at: $0, animated: context.isAnimated, scrollPosition: [])
                    }
                }
            })
        }
    }

}
