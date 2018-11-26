//
//  IssuePreviewSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssuePreviewViewController: UIViewController, ListAdapterDataSource {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout.basic())
    private let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    private let markdown: String
    private let owner: String
    private let repo: String
    private var model: IssuePreviewModel?

    init(
        markdown: String,
        owner: String,
        repo: String,
        title: String,
        asMenu: Bool = false
        ) {
        self.markdown = markdown
        self.owner = owner
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
        self.title = title
        if asMenu {
            preferredContentSize = Styles.Sizes.contextMenuSize
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModels = MarkdownModels(
            markdown,
            owner: owner,
            repo: repo,
            width: view.safeContentWidth(with: collectionView),
            viewerCanUpdate: false,
            contentSizeCategory: UIContentSizeCategory.preferred,
            isRoot: false
        )
        model = IssuePreviewModel(models: viewModels)

        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let model = self.model else { return [] }
        return [model]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return IssuePreviewSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
