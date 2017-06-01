//
//  IssueCommentReactionCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class IssueCommentReactionCell: UICollectionViewCell, IGListBindable {

    static let reuse = "cell"

    let addButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Styles.Sizes.icon
        layout.minimumInteritemSpacing = Styles.Sizes.columnSpacing / 2.0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IssueLabelDotCell.self, forCellWithReuseIdentifier: IssueCommentReactionCell.reuse)
        return view
    }()

    typealias ReactionViewModel = (emoji: String, count: Int)
    var reactions = [ReactionViewModel]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addButton.tintColor = Styles.Colors.Gray.light
        addButton.setTitle("+", for: .normal)
        addButton.setImage(UIImage(named: "smiley")?.withRenderingMode(.alwaysTemplate), for: .normal)
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(addButton.snp.right).offset(Styles.Sizes.columnSpacing)
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

    // MARK: IGListBindable

    

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? Reaction else { return }
        var models = [ReactionViewModel]()

        let plus1 = viewModel.plus1.intValue
        if plus1 > 0 {
            models.append(("👍", plus1))
        }

        let minus1 = viewModel.minus1.intValue
        if minus1 > 0 {
            models.append(("👎", minus1))
        }

        let laugh = viewModel.laugh.intValue
        if laugh > 0 {
            models.append(("😄", laugh))
        }

        let hooray = viewModel.hooray.intValue
        if hooray > 0 {
            models.append(("🎉", hooray))
        }

        let confused = viewModel.confused.intValue
        if confused > 0 {
            models.append(("😕", confused))
        }

        let heart = viewModel.heart.intValue
        if heart > 0 {
            models.append(("❤️", heart))
        }

        reactions = models
        collectionView.reloadData()
    }
    
}

extension IssueCommentReactionCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: IssueCommentReactionCell.reuse, for: indexPath)
    }

}
