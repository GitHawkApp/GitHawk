//
//  ProjectColumnSectionController.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class ProjectColumnSectionController: ListGenericSectionController<Project.Details.Column> {
    
    let topLayoutGuide: UILayoutSupport
    let bottomLayoutGuide: UILayoutSupport
    
    var feed: Feed? // Set once the cell is configured
    var firstLoad = true
    var cards: [Project.Details.Column.Card]?
    
    init(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        self.topLayoutGuide = topLayoutGuide
        self.bottomLayoutGuide = bottomLayoutGuide
        super.init()
        self.inset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let size = collectionContext?.insetContainerSize else { fatalError("Missing context") }
        return CGSize(width: size.width * 0.8, height: size.height - topLayoutGuide.length)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ProjectColumnCell.self, for: self, at: index) as? ProjectColumnCell,
            let object = self.object, let viewController = viewController else {
                fatalError("Missing context, object, or cell is wrong type")
        }
        
        cell.configure(object, viewController: viewController, feedDelegate: self)
        
        feed = cell.feed
        feed?.collectionView.refreshControl = nil
        feed?.viewDidLoad()
        feed?.adapter.dataSource = self
        
        return cell
    }
    
}

extension ProjectColumnSectionController: FeedDelegate, ListAdapterDataSource {
    
    // MARK: - Loading
    
    private func update() {
        feed?.finishLoading(dismissRefresh: true, animated: true, completion: nil)
    }
    
    private func reload() {
        print("reload")
    }
    
    // MARK: - FeedDelegate
    
    func loadFromNetwork(feed: Feed) {
        if firstLoad {
            cards = object?.cards
            update()
            return
        }
        
        reload()
    }
    
    func loadNextPage(feed: Feed) -> Bool {
        return false
    }
    
    // MARK: - ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        fatalError()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
