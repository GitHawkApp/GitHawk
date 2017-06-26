//
//  SettingsUsersSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsUsersSectionController: ListBindingSectionController<GithubSessionManager>,
    ListBindingSectionControllerDataSource,
ListBindingSectionControllerSelectionDelegate {

    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }

    fileprivate var activeSessions: [GithubUserSession] {
        guard let object = self.object else { return [] }
        return object.allUserSessions.sorted { $0.login < $1.login }
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        let focusedLogin = self.object?.focusedLogin
        return activeSessions.map { SettingsUserModel(name: $0.login, selected: focusedLogin == $0.login) }
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width
            else { fatalError("Collection context must be set") }
        return CGSize(width: width, height: Styles.Sizes.tableCellHeight)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = collectionContext
            else { fatalError("Collection context must be set") }
        return context.dequeueReusableCell(of: SettingsUserCell.self, for: self, at: index)
    }

    // MARK: ListBindingSectionControllerSelectionDelegate

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        didSelectItemAt index: Int,
        viewModel: Any
        ) {
        guard let object = self.object else { return }
        object.focus(activeSessions[index])
    }

}

