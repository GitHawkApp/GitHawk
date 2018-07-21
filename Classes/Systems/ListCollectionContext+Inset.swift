//
//  ListCollectionContext+Inset.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

extension ListCollectionContext {

    func adjustedContainerSize(for sectionController: ListSectionController) -> CGSize {
        let size = insetContainerSize
        let inset = sectionController.inset
        return CGSize(
            width: size.width - inset.left - inset.right,
            height: size.height - inset.top - inset.bottom
        )
    }

}
