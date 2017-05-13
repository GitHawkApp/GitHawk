//
//  ListTestKit.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class ListTestKit: NSObject, IGListAdapterDataSource {

    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let adapter = IGListAdapter(updater: IGListAdapterUpdater(), viewController: nil)

    var objects: [IGListDiffable] = []
    var sectionControllerBlock: (Any) -> (IGListSectionController) = { _ in
        return IGListSectionController()
    }

    func setup() {
        window.addSubview(collectionView)
        collectionView.frame = window.bounds
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return objects
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return sectionControllerBlock(object)
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}
