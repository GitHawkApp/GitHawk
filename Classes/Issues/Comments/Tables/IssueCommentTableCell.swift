//
//  IssueCommentTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol IssueCommentTableCellDelegate: class {
    func didTapURL(cell: IssueCommentTableCell, url: URL)
    func didTapUsername(cell: IssueCommentTableCell, username: String)
}

final class IssueCommentTableCell: UICollectionViewCell,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
IssueCommentTableCollectionCellDelegate {

    static let inset = Styles.Sizes.textCellInset

    weak var delegate: IssueCommentTableCellDelegate? = nil

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let identifier = "cell"
    private var model: IssueCommentTableModel? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(IssueCommentTableCollectionCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPrefetchingEnabled = false
        contentView.addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = UIEdgeInsetsInsetRect(contentView.bounds, IssueCommentTableCell.inset)
    }

    // MARK: Public API

    func configure(_ model: IssueCommentTableModel) {
        self.model = model
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model?.columns.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.columns[section].items.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueCommentTableCollectionCell,
            let item = model?.columns[indexPath.section].items[indexPath.item]
            else { fatalError("Cell is wrong type or missing model/item") }
        cell.configure(item)
        cell.delegate = self
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        guard let column = model?.columns[indexPath.section] else { fatalError("Missing model") }
        return CGSize(width: column.width, height: column.height)
    }

    // MARK: IssueCommentTableCollectionCellDelegate

    func didTapURL(cell: IssueCommentTableCollectionCell, url: URL) {
        delegate?.didTapURL(cell: self, url: url)
    }

    func didTapUsername(cell: IssueCommentTableCollectionCell, username: String) {
        delegate?.didTapUsername(cell: self, username: username)
    }

}
