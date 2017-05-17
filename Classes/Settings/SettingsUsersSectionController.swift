//
//  SettingsUsersSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsUsersSectionController: IGListBindingSectionController<GithubSession> {

}

extension SettingsUsersSectionController: IGListBindingSectionControllerDataSource {

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, viewModelsFor object: Any) -> [IGListDiffable] {
        return []
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        return .zero
    }

    func sectionController(_ sectionController: IGListBindingSectionController<IGListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
