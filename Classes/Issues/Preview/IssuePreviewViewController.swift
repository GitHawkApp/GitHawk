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

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    private let markdown: String
    private let owner: String
    private let repo: String
    private var model: IssuePreviewModel?

    init(
        markdown: String,
        owner: String,
        repo: String
        ) {
        self.markdown = markdown
        self.owner = owner
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("Preview", comment: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let options = GitHubMarkdownOptions(owner: owner, repo: repo, flavors: [.issueShorthand, .usernames])
        let viewModels = CreateCommentModels(
            markdown: markdown,
            width: view.bounds.width,
            options: options
        )
        model = IssuePreviewModel(models: viewModels)

        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = Styles.Sizes.listInsetLarge
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
