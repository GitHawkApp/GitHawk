//
//  IssueCommentTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol IssueCommentTableCellDelegate: class {
    func didTapURL(cell: IssueCommentTableCell, url: URL)
    func didTapUsername(cell: IssueCommentTableCell, username: String)
}

final class IssueCommentTableCell: UICollectionViewCell,
    ListBindable,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
IssueCommentTableCollectionCellDelegate {

    static let inset = UIEdgeInsets(top: 0, left: 4, bottom: Styles.Sizes.rowSpacing, right: 4)

    weak var delegate: IssueCommentTableCellDelegate? = nil

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let identifier = "cell"
    private var model: IssueCommentTableModel? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white

        collectionView.register(IssueCommentTableCollectionCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPrefetchingEnabled = false
        collectionView.contentInset = IssueCommentTableCell.inset
        contentView.addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentTableModel else { return }
        self.model = viewModel
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model?.columns.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.columns[section].rows.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueCommentTableCollectionCell,
            let columns = model?.columns
            else { fatalError("Cell is wrong type or missing model/item") }

        let column = columns[indexPath.section]
        let rows = column.rows
        let row = rows[indexPath.item]
        cell.configure(row.text)
        cell.delegate = self
        cell.contentView.backgroundColor = row.fill ? Styles.Colors.Gray.lighter.color : .white
        cell.setRightBorder(visible: columns.last === column)
        cell.setBottomBorder(visible: rows.last === row)

        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        guard let model = model else { fatalError("Missing model") }
        return CGSize(width: model.columns[indexPath.section].width, height: model.rowHeight)
    }

    // MARK: IssueCommentTableCollectionCellDelegate

    func didTapURL(cell: IssueCommentTableCollectionCell, url: URL) {
        delegate?.didTapURL(cell: self, url: url)
    }

    func didTapUsername(cell: IssueCommentTableCollectionCell, username: String) {
        delegate?.didTapUsername(cell: self, username: username)
    }

}
