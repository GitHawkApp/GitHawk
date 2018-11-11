//
//  ContentWidthUtilsTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime
import IGListKit

let hackGlobalSafeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

class AdjustableCollectionView: UICollectionView {
    // hack to fake iPhone X+ insetting for notch in landscape
    override var adjustedContentInset: UIEdgeInsets {
        get {
            return UIEdgeInsets(
                top: contentInset.top + hackGlobalSafeInsets.top,
                left: contentInset.left + hackGlobalSafeInsets.left,
                bottom: contentInset.bottom + hackGlobalSafeInsets.bottom,
                right: contentInset.right + hackGlobalSafeInsets.right
            )
        }
        set { }
    }
    static func make() -> AdjustableCollectionView {
        return AdjustableCollectionView(
            frame: .zero,
            collectionViewLayout: ListCollectionViewLayout.basic()
        )
    }
}

class InsetTestCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView(for: hackGlobalSafeInsets)
    }
}

class InsetTestSectionController: ListSectionController {

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.cellWidth(), height: 100)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        return collectionContext!.dequeueReusableCell(
            of: InsetTestCell.self,
            for: self,
            at: index
        )
    }

}

class InsetTestController: NSObject, ListAdapterDataSource {

    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)

    override init() {
        super.init()
        adapter.dataSource = self
    }

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return ["foo", "bar", "baz"] as [ListDiffable]
    }

    func listAdapter(
        _ listAdapter: ListAdapter,
        sectionControllerFor object: Any
        ) -> ListSectionController {
        return InsetTestSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

class ContentWidthUtilsTests: XCTestCase {

    func test_collectionViewFrameWidth() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let collectionView = AdjustableCollectionView.make()
        collectionView.frame = view.frame
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.addSubview(collectionView)
        XCTAssertEqual(view.safeContentWidth(with: collectionView), 260)
    }

    func test_listKit() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let collectionView = AdjustableCollectionView.make()
        collectionView.frame = view.frame
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.addSubview(collectionView)
        XCTAssertEqual(view.safeContentWidth(with: collectionView), 260)

        let controller = InsetTestController()
        controller.adapter.collectionView = collectionView
        collectionView.layoutIfNeeded()

        XCTAssertEqual(collectionView.numberOfSections, 3)
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertNotNil(collectionView.cellForItem(at: IndexPath(item: 0, section: 0)))

        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! InsetTestCell
        XCTAssertEqual(cell.bounds.size, CGSize(width: 280, height: 100))
        XCTAssertEqual(cell.contentView.frame, CGRect(x: 20, y: 0, width: 260, height: 100))
    }

}
