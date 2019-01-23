//
//  RepositoryOverviewHeaderViewModels.swift
//  Freetime
//
//  Created by Viktoras Laukevicius on 23/01/2019.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledTextKit

struct RepositoryOverviewHeaderModel {
    let watchersCount: Int
    let starsCount: Int
    let forksCount: Int
}

private extension Int {
    var localizedDecimal: String {
        return NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}

func RepositoryOverviewHeaderViewModels(
    model: RepositoryOverviewHeaderModel,
    width: CGFloat,
    contentSizeCategory: UIContentSizeCategory
    ) -> [ListDiffable] {
    let watchersCount = model.watchersCount.localizedDecimal
    let starsCount = model.starsCount.localizedDecimal
    let forksCount = model.forksCount.localizedDecimal
    let iconsStyle = Styles.Text.h2
    let textStyle = Styles.Text.secondaryBold
    let builder = StyledTextBuilder(styledText: StyledText(
        style: iconsStyle.with(foreground: Styles.Colors.Gray.medium.color)
    ))
        .save()
    let baselineOffset = (iconsStyle.preferredFont.lineHeight - textStyle.preferredFont.lineHeight) / 4.0
    let elements = [
        (UIImage(named: "eye")!, watchersCount),
        (UIImage(named: "star")!, starsCount),
        (UIImage(named: "repo-forked")!, forksCount)
        ]
    for (image, countText) in elements {
        builder
            .add(image: image)
            .add(styledText: StyledText(text: " \(countText)   ", style: textStyle.with(attributes: [
                .baselineOffset: baselineOffset
                ])
            ))
            .restore()
            .save()
    }

    let hdr = StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: contentSizeCategory,
        inset: .zero
        ).warm(width: width)
    return [hdr]
}
