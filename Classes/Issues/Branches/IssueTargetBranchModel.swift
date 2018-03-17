//
//  IssueTargetBranchModel.swift
//  Freetime
//
//  Created by Yury Bogdanov on 13/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueTargetBranchModel: ListDiffable {
    
    let targetBranchText: NSAttributedStringSizing

    
    init(branch: String, width: CGFloat) {
        
        let branchTitleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.secondaryCode.preferredFont,
        ]
        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.secondaryBold.preferredFont
        ]
        
        let titleAttributedText = NSMutableAttributedString(string: "Target branch: ", attributes: titleAttributes)
        let branchAttributedTitle = NSAttributedString(string: branch, attributes: branchTitleAttributes)
        
        titleAttributedText.append(branchAttributedTitle)
        self.targetBranchText = NSAttributedStringSizing(containerWidth: width, attributedText: titleAttributedText, inset: IssueTargetBranchCell.inset, backgroundColor: Styles.Colors.Gray.lighter.color)
    }
    
    // MARK: ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return targetBranchText.diffIdentifier()
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueTargetBranchModel else { return false }
        return targetBranchText.isEqual(toDiffableObject: object)
    }
}
