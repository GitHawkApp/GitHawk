//
//  IGListSectionController+Utils.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension ListSectionController {

    var util_context: ListCollectionContext {
        guard let context = collectionContext else {
            fatalError("Missing context")
        }
        return context
    }

    func util_dequeueCell<T: AnyObject>(index: Int) -> T {
        guard let cell = collectionContext?.dequeueReusableCell(of: T.self, for: self, at: index) as? T else {
            fatalError("Missing context or wrong cell")
        }
        return cell
    }

}
