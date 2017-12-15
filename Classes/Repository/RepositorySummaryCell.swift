//
//  RepositorySummaryCell.swift
//  Freetime
//
//  Created by Sherlock, James on 29/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class RepositorySummaryCell: SelectableCell {

    static let labelDotSize = CGSize(width: 10, height: 10)
    static let titleInset = UIEdgeInsets(
        top: Styles.Sizes.rowSpacing,
        left: Styles.Sizes.icon.width + 2*Styles.Sizes.columnSpacing,
        bottom: Styles.Sizes.rowSpacing,
        right: Styles.Sizes.gutter
    )

    private let reasonImageView = UIImageView()
    private let titleView = AttributedStringView()
    private let detailsStackView = UIStackView()
    private let secondaryLabel = UILabel()
    private let labelDotView = DotListView(dotSize: RepositorySummaryCell.labelDotSize)

    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityTraits |= UIAccessibilityTraitButton
        isAccessibilityElement = true

        backgroundColor = .white

        contentView.addSubview(reasonImageView)
        contentView.addSubview(titleView)
        contentView.addSubview(detailsStackView)

        reasonImageView.backgroundColor = .clear
        reasonImageView.contentMode = .scaleAspectFit
        reasonImageView.tintColor = Styles.Colors.Blue.medium.color
        reasonImageView.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.icon)
            make.centerY.equalToSuperview()
            make.left.equalTo(Styles.Sizes.columnSpacing)
        }

        detailsStackView.axis = .vertical
        detailsStackView.alignment = .leading
        detailsStackView.distribution = .fill
        detailsStackView.spacing = Styles.Sizes.rowSpacing
        detailsStackView.addArrangedSubview(secondaryLabel)
        detailsStackView.addArrangedSubview(labelDotView)
        detailsStackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-Styles.Sizes.rowSpacing)
            make.left.equalTo(reasonImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.right.equalTo(contentView.snp.right).offset(-Styles.Sizes.columnSpacing)
        }

        secondaryLabel.numberOfLines = 1
        secondaryLabel.font = Styles.Text.secondary.preferredFont
        secondaryLabel.textColor = Styles.Colors.Gray.light.color

        labelDotView.snp.makeConstraints { make in
            make.height.equalTo(RepositorySummaryCell.labelDotSize.height)
            make.left.right.equalTo(detailsStackView)
        }

        contentView.addBorder(.bottom, left: RepositorySummaryCell.titleInset.left)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.reposition(width: contentView.bounds.width)
    }

    // MARK: Public API

    func configure(_ model: RepositoryIssueSummaryModel) {
        titleView.configureAndSizeToFit(text: model.title, width: contentView.bounds.width)

        let format = NSLocalizedString("#%d opened %@ by %@", comment: "")
        secondaryLabel.text = String.localizedStringWithFormat(format, model.number, model.created.agoString, model.author)

        let imageName: String
        let tint: UIColor
        switch model.status {
        case .closed:
            imageName = model.pullRequest ? "git-pull-request" : "issue-closed"
            tint = Styles.Colors.Red.medium.color
        case .open:
            imageName = model.pullRequest ? "git-pull-request" : "issue-opened"
            tint = Styles.Colors.Green.medium.color
        case .merged:
            imageName = "git-merge"
            tint = Styles.Colors.purple.color
        }

        reasonImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        reasonImageView.tintColor = tint

        if model.labels.count > 0 {
            labelDotView.isHidden = false
            let colors = model.labels.map { UIColor.fromHex($0.color) }
            labelDotView.configure(colors: colors)
        } else {
            labelDotView.isHidden = true
        }
    }

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}
