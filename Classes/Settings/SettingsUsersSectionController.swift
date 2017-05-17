//
//  SettingsUsersSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsUsersSectionController: IGListBindingSectionController<GithubSessionManager> {

    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0, left: 0, bottom: Styles.Sizes.tableSectionSpacing, right: 0)
    }

}

extension SettingsUsersSectionController: IGListBindingSectionControllerDataSource {

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, viewModelsFor object: Any) -> [IGListDiffable] {
        guard let object = self.object else { return [] }
        let focusedLogin = object.focusedLogin
        return object.allUserSessions
            .map { SettingsUserModel(name: $0.login, selected: focusedLogin == $0.login) }
            .sorted { $0.name < $1.name }
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        guard let context = self.collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: Styles.Sizes.tableCellHeight)
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell {
        guard let context = self.collectionContext else { return UICollectionViewCell() }
        return context.dequeueReusableCell(of: SettingsUserCell.self, for: self, at: index)
    }
    
}
