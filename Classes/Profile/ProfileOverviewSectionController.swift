//
//  ProfileOverviewSectionController.swift
//  Freetime
//
//  Created by B_Litwin on 8/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit


final class ProfileOverviewSectionController: ListBindingSectionController<UserProfileModel>,
ListBindingSectionControllerDataSource{
    
    override init() {
        super.init()
        dataSource = self
        inset = UIEdgeInsets(top: 0,
                             left: Styles.Sizes.gutter,
                             bottom: 0,
                             right: Styles.Sizes.gutter)
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        guard let object = object as? UserProfileModel else { return [] }
        var viewModels = [ListDiffable]()
        
        viewModels.append (
            ProfileImageAndDetailViewModel(avatarURL: object.avatarURL,
                                           login: object.login,
                                           name: object.name,
                                           location: object.location
            )
        )
        
        return viewModels
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, cellForViewModel viewModel: Any, at index: Int) -> UICollectionViewCell & ListBindable {

        switch viewModel {
        case is ProfileImageAndDetailViewModel:
            guard let cell = collectionContext?.dequeueReusableCell(of: ProfileImageAndDetailCollectionViewCell.self,
                                                                    for: self,
                                                                    at: index) as? ProfileImageAndDetailCollectionViewCell else {
                fatalError("Missing context or wrong cell type")
            }
            return cell
            
        default: fatalError("Unsupported model \(viewModel)")
        }
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, sizeForViewModel viewModel: Any, at index: Int) -> CGSize {
        
        let width = (collectionContext?.insetContainerSize.width ?? 0) - inset.left - inset.right
        
        switch viewModel {
        case is ProfileImageAndDetailViewModel:
            return CGSize(width: width, height: 65)
            
        default:
            fatalError("Unsupported model \(viewModel)")
        }
    }
}








