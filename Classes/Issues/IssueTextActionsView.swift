//
//  IssueTextActionsView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class IssueTextActionsCell: SelectableCell {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.tintColor = Styles.Colors.Gray.dark.color
        imageView.contentMode = .center
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    func configure(operation: IssueTextActionOperation) {
        imageView.image = operation.icon
        imageView.accessibilityLabel = operation.name
    }

    override var accessibilityLabel: String? {
        get {
            return AccessibilityHelper.generatedLabel(forCell: self)
        }
        set { }
    }

}

protocol IssueTextActionsViewDelegate: class {
    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation)
}

struct IssueTextActionOperation {

    enum Operation {
        case line(String)
        case wrap(String, String)
        case execute(() -> Void)
        case uploadImage
    }

    let icon: UIImage?
    let operation: Operation
    let name: String

}

final class IssueTextActionsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: IssueTextActionsViewDelegate?

    private let operations: [IssueTextActionOperation]
    private let identifier = "cell"
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.alwaysBounceVertical = false
        c.alwaysBounceHorizontal = true
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
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
        cell.configure(operation: operations[indexPath.item])
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelect(actionsView: self, operation: operations[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(
            width: (operations[indexPath.item].icon?.size.width ?? 0) + Styles.Sizes.eventGutter*2,
            height: height
        )
    }

}
