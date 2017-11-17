//
//  IGListCollectionViewLayout+GitHawk.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ListCollectionViewLayout {

    static func basic() -> ListCollectionViewLayout {
        return ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
    }

}
