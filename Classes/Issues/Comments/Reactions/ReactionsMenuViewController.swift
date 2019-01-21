//
//  ReactionsMenuViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: Styles.Text.body.size + 4)
        contentView.addSubview(label)

        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = Styles.Colors.Gray.medium.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }

}

final class ReactionsMenuViewController: UICollectionViewController,
    UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "cell"
    private let size: CGFloat = 50

    private let sectionedReactions: [[ReactionContent]] = [
        [
            .thumbsUp,
            .thumbsDown,
            .laugh,
            .hooray
        ],
        [
            .confused,
            .heart,
            .rocket,
            .eyes
        ]
    ]

    var selectedReaction: ReactionContent? {
        guard let item = collectionView?.indexPathsForSelectedItems?.first else { return nil }
        return sectionedReactions[item.section][item.item]
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = Styles.Colors.menuBackgroundColor.color
        collectionView?.register(EmojiCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.reloadData()
        collectionView?.layoutIfNeeded()
        let reactionsInRow = sectionedReactions.first?.count ?? 0
        preferredContentSize = CGSize(
            width: size * CGFloat(reactionsInRow),
            height: size * CGFloat(sectionedReactions.count)
        )
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionedReactions.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionedReactions[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? EmojiCell {
            cell.label.text = sectionedReactions[indexPath.section][indexPath.item].emoji
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: size,
            height: size
        )
    }

}
