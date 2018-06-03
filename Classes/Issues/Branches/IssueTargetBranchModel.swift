//
//  IssueTargetBranchModel.swift
//  Freetime
//
//  Created by Yury Bogdanov on 13/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueTargetBranchModel: ListDiffable {
    
    let targetBranchText: StyledTextRenderer

    
    init(branch: String, width: CGFloat) {
        let builder = StyledTextBuilder(styledText: StyledText(
            style: Styles.Text.secondary.with(foreground: Styles.Colors.Gray.medium.color)
        ))
        .save()
        .add(styledText: StyledText(
            text: "Target branch: ")
        )
        .save()
        .add(styledText: StyledText(
            text: branch,
            style: Styles.Text.secondaryCode.with(foreground: Styles.Colors.Gray.dark.color)
        ))
        .save()
        
        self.targetBranchText = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: .small,
            inset: .zero,
            backgroundColor: Styles.Colors.background
        ).warm(width: width)
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
