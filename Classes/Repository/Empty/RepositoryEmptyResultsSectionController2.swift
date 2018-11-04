//
//  RepositoryEmptyResultsSectionController2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

final class RepositoryEmptyResultsSectionController2: ListSwiftSectionController<String> {

    let layoutInsets: UIEdgeInsets
    let type: RepositoryEmptyResultsType

    init(layoutInsets: UIEdgeInsets, type: RepositoryEmptyResultsType) {
        self.layoutInsets = layoutInsets
        self.type = type
        super.init()
    }

    override func createBinders(from value: String) -> [ListBinder] {
        return [
            binder(
                value,
                cellType: ListCellType.class(RepositoryEmptyResultsCell.self),
                size: { [weak self] context in
                    guard let `self` = self else { return .zero }
                    let size = context.collection.containerSize
                    return CGSize(
                        width: size.width,
                        height: size.height - self.layoutInsets.top - self.layoutInsets.bottom
                    )
            })
        ]
    }

//    override func sizeForItem(at index: Int) -> CGSize {
//        guard let size = collectionContext?.containerSize else { fatalError("Missing context") }
//        return CGSize(width: size.width, height: size.height - topInset - layoutInsets.top - layoutInsets.bottom)
//    }
//
//    override func cellForItem(at index: Int) -> UICollectionViewCell {
//        guard let cell = collectionContext?.dequeueReusableCell(of: RepositoryEmptyResultsCell.self, for: self, at: index) as? RepositoryEmptyResultsCell else {
//            fatalError("Missing context, object, or cell is wrong type")
//        }
//
//        cell.configure(type)
//        return cell
//    }

}
