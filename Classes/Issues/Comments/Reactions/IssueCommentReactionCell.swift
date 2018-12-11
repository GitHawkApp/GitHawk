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

protocol IssueCommentReactionCellDelegate: class {
    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent)
    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent)
    func didTapMore(cell: IssueCommentReactionCell, sender: UIView)
    func didTapAddReaction(cell: IssueCommentReactionCell, sender: UIView)
}

final class IssueCommentReactionCell: UICollectionViewCell,
ListBindable,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    static let reuse = "cell"

    public weak var delegate: IssueCommentReactionCellDelegate?

    private let addButton = ResponderButton()
    private let moreButton = HittableButton()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IssueReactionCell.self, forCellWithReuseIdentifier: IssueCommentReactionCell.reuse)
        return view
    }()
    private var reactions = [ReactionViewModel]()
    private var queuedOperation: (content: ReactionContent, operation: IssueReactionOperation)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addButton.tintColor = Styles.Colors.Gray.light.color
        addButton.setTitle("+", for: .normal)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        addButton.setTitleColor(Styles.Colors.Gray.light.color, for: .normal)
        addButton.setImage(UIImage(named: "smiley-small").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.addTarget(self, action: #selector(IssueCommentReactionCell.onAddButton(sender:)), for: .touchUpInside)
        addButton.accessibilityLabel = NSLocalizedString("Add reaction", comment: "")
        addButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Styles.Sizes.rowSpacing)
        }

        moreButton.setImage(UIImage(named: "bullets-small").withRenderingMode(.alwaysTemplate), for: .normal)
        moreButton.contentVerticalAlignment = .center
        moreButton.contentHorizontalAlignment = .right
        moreButton.imageView?.contentMode = .center
        moreButton.tintColor = Styles.Colors.Gray.light.color
        moreButton.addTarget(self, action: #selector(IssueCommentReactionCell.onMore(sender:)), for: .touchUpInside)
        moreButton.accessibilityLabel = Constants.Strings.moreOptions
        contentView.addSubview(moreButton)
        moreButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        moreButton.snp.makeConstraints { make in
            make.size.equalTo(Styles.Sizes.buttonMin)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.clipsToBounds = true
        collectionView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(addButton.snp.right).offset(Styles.Sizes.columnSpacing)
            make.top.bottom.right.equalToSuperview()
            make.right.equalTo(moreButton.snp.left).offset(-Styles.Sizes.columnSpacing)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()
    }

    // MARK: Public API

    func perform(operation: IssueReactionOperation, content: ReactionContent) {
        // store the content:operation pair for next binding
        // implies that IGListBindingSectionController will do its thing, and this method is called
        // in sectionController(_, cellForViewModel:,at index:)
        queuedOperation = (content, operation)
    }

    // MARK: Private API

    func cell(for content: ReactionContent) -> IssueReactionCell? {
        guard let idx = reactions.index(where: { (model: ReactionViewModel) -> Bool in
            return model.content == content
        }) else { return nil }
        let path = IndexPath(item: idx, section: 0)
        return collectionView.cellForItem(at: path) as? IssueReactionCell
    }

    @objc private func onAddButton(sender: UIView) {
        delegate?.didTapAddReaction(cell: self, sender: sender)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(IssueCommentReactionCell.onThumbsUp),
             #selector(IssueCommentReactionCell.onThumbsDown),
             #selector(IssueCommentReactionCell.onLaugh),
             #selector(IssueCommentReactionCell.onHooray),
             #selector(IssueCommentReactionCell.onConfused),
             #selector(IssueCommentReactionCell.onHeart):
            return true
        default: return false
        }
    }

    @objc private func onThumbsUp() {
        delegate?.didAdd(cell: self, reaction: .thumbsUp)
    }

    @objc private func onThumbsDown() {
        delegate?.didAdd(cell: self, reaction: .thumbsDown)
    }

    @objc private func onLaugh() {
        delegate?.didAdd(cell: self, reaction: .laugh)
    }

    @objc private func onHooray() {
        delegate?.didAdd(cell: self, reaction: .hooray)
    }

    @objc private func onConfused() {
        delegate?.didAdd(cell: self, reaction: .confused)
    }

    @objc private func onHeart() {
        delegate?.didAdd(cell: self, reaction: .heart)
    }

    func configure(cell: IssueReactionCell, model: ReactionViewModel) {
        let detail = createReactionDetailText(model: model)

        cell.configure(
            emoji: model.content.emoji,
            count: model.count,
            detail: detail,
            isViewer: model.viewerDidReact
        )
    }

    func data(for content: ReactionContent) -> (path: IndexPath, cell: IssueReactionCell)? {
        guard let idx = reactions.index(where: { (model: ReactionViewModel) -> Bool in
            return model.content == content
        }) else { return nil }
        let path = IndexPath(item: idx, section: 0)
        guard let cell = collectionView.cellForItem(at: path) as? IssueReactionCell else { return nil }
        return (path, cell)
    }

    func iterate(content: ReactionContent, add: Bool) {
        guard let data = data(for: content) else { return }
        configure(cell: data.cell, model: reactions[data.path.item])
        data.cell.iterate(add: add)
    }

    @objc func onMore(sender: UIView) {
        delegate?.didTapMore(cell: self, sender: sender)
    }

    // MARK: ListBindable

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? IssueCommentReactionViewModel else { return }

        // if add:first, cell needs to be inserted THEN popIn()
        // if sub:last, cell needs to pullOut() THEN deleted
        // else incr/decr
        if let queued = queuedOperation {
            queuedOperation = nil

            switch queued.operation {
            case .add:
                self.reactions = viewModel.models
                iterate(content: queued.content, add: true)
            case .subtract:
                self.reactions = viewModel.models
                iterate(content: queued.content, add: false)
            case .insert:
                self.reactions = viewModel.models
                self.collectionView.reloadData()
                // required after changing data and trying to retrieve a cell before next layout pass
                self.collectionView.layoutIfNeeded()
                if let data = data(for: queued.content) {
                    data.cell.popIn()
                }
            case .remove:
                if let data = data(for: queued.content) {
                    data.cell.pullOut()
                    self.reactions = viewModel.models
                    self.collectionView.deleteItems(at: [data.path])
                }
            case .none: break
            }
        } else {
            self.reactions = viewModel.models
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactions.count
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IssueCommentReactionCell.reuse,
            for: indexPath
            ) as! IssueReactionCell
        configure(cell: cell, model: reactions[indexPath.item])
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    internal func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        let reaction = reactions[indexPath.item]
        let width = IssueReactionCell.width(emoji: reaction.content.emoji, count: reaction.count)
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    // MARK: UICollectionViewDelegate

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = reactions[indexPath.item]
        if model.viewerDidReact {
            delegate?.didRemove(cell: self, reaction: model.content)
        } else {
            delegate?.didAdd(cell: self, reaction: model.content)
        }
    }

}
