//
//  IssueTextActionsView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueTextActionsCell: UICollectionViewCell {

    let label = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let color = Styles.Colors.Gray.dark.color

        label.font = Styles.Fonts.button
        label.textColor = color
        label.backgroundColor = .clear
        contentView.addSubview(label)

        imageView.tintColor = color
        imageView.contentMode = .center
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        imageView.frame = contentView.bounds
    }

}

protocol IssueTextActionsViewDelegate: class {
    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation)
}

struct IssueTextActionOperation {

    enum Icon {
        case text(NSAttributedString)
        case image(UIImage?)
    }

    enum Operation {
        case line(String)
        case wrap(String, String)
        case execute(() -> ())
    }

    let icon: Icon
    let operation: Operation

}

final class IssueTextActionsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: IssueTextActionsViewDelegate? = nil

    private let operations: [IssueTextActionOperation]
    private let identifier = "cell"
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.alwaysBounceVertical = false
        c.alwaysBounceHorizontal = true
        c.contentInset = UIEdgeInsets(top: 0, left: Styles.Sizes.gutter, bottom: 0, right: Styles.Sizes.gutter)
        return c
    }()

    init(operations: [IssueTextActionOperation]) {
        self.operations = operations

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(IssueTextActionsCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return operations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? IssueTextActionsCell
            else { fatalError("Wrong cell type") }

        let operation = operations[indexPath.item]
        switch operation.icon {
        case .image(let image): cell.imageView.image = image
        case .text(let text): cell.label.attributedText = text
        }

        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(actionsView: self, operation: operations[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: height, height: height)
    }
    
}
