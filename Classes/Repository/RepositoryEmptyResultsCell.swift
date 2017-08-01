//
//  RepositoryEmptyResultsCell.swift
//  Freetime
//
//  Created by Sherlock, James on 01/08/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

enum EmptyResultsType {
    case issues
    case pullRequests
    
    var icon: UIImage? {
        switch self {
        case .issues: return UIImage(named: "issue-opened")
        case .pullRequests: return UIImage(named: "git-pull-request")
        }
    }
    
    var text: String {
        switch self {
        case .issues: return NSLocalizedString("This repository currently has no issues!", comment: "")
        case .pullRequests: return NSLocalizedString("This repository currently has no pull requests!", comment: "")
        }
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        switch self {
        case .issues: return "issues" as NSObjectProtocol
        case .pullRequests: return "pullRequests" as NSObjectProtocol
        }
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? EmptyResultsType else { return false }
        return self == object
    }
}

final class RepositoryEmptyResultsCell: UICollectionViewCell {
    
    var type: EmptyResultsType? {
        didSet {
            icon.image = type?.icon?.withRenderingMode(.alwaysTemplate)
            label.text = type?.text
        }
    }
    
    private let icon = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityTraits = UIAccessibilityTraitStaticText
        isAccessibilityElement = true
        
        icon.tintColor = Styles.Colors.Gray.dark.color
        icon.contentMode = .scaleAspectFit
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView).offset(-Styles.Sizes.tableSectionSpacing)
            make.width.equalTo(icon.snp.height)
            make.width.equalTo(50)
        }
        
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = Styles.Fonts.body
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).offset(Styles.Sizes.tableSectionSpacing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var accessibilityLabel: String? {
        get {
            return contentView.subviews
                .flatMap { $0.accessibilityLabel }
                .reduce("", { $0 + ".\n" + $1 })
        }
        set { }
    }
    
}
