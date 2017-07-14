//
//  IssueAssigneeSummaryCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

final class IssueAssigneeSummaryCell: UICollectionViewCell, UICollectionViewDataSource, ListBindable {

    static let reuse = "cell"

    private let label = UILabel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Styles.Sizes.icon
        layout.minimumLineSpacing = Styles.Sizes.columnSpacing / 2.0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IssueAssigneeAvatarCell.self, forCellWithReuseIdentifier: IssueAssigneeSummaryCell.reuse)
        return view
    }()

    private var urls = [URL]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.font = Styles.Fonts.secondary
        label.textColor = Styles.Colors.Gray.light.color
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.gutter)
        }

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(Styles.Sizes.columnSpacing)
            make.top.bottom.right.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let height = contentView.bounds.height
        let size = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
        let inset = (height - size.height)/2
        collectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueAssigneeSummaryModel else { return }
        label.text = viewModel.title
        urls = viewModel.expanded ? [] : viewModel.urls
        collectionView.reloadData()
        setNeedsLayout()
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueAssigneeSummaryCell.reuse, for: indexPath) as? IssueAssigneeAvatarCell
            else { fatalError("Wrong cell type") }
        cell.configure(urls[indexPath.item])
        return cell
    }

}
