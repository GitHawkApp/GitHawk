//
//  ListTestKit.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class ListTestKit: NSObject, ListAdapterDataSource {

    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

    var objects: [ListDiffable] = []
    var sectionControllerBlock: (Any) -> (ListSectionController) = { _ in
        return ListSectionController()
    }

    func setup() {
        window.addSubview(collectionView)
        collectionView.frame = window.bounds
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return sectionControllerBlock(object)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
