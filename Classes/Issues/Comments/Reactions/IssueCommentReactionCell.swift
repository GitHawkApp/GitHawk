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

protocol IssueCommentReactionCellDelegate {
    func didToggle(cell: IssueCommentReactionCell, reaction: ReactionContent)
    func didAdd(cell: IssueCommentReactionCell, reaction: ReactionContent)
    func didRemove(cell: IssueCommentReactionCell, reaction: ReactionContent)
}

final class IssueCommentReactionCell: UICollectionViewCell,
ListBindable,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    static let reuse = "cell"

    public var delegate: IssueCommentReactionCellDelegate? = nil

    private let addButton = ResponderButton()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IssueReactionCell.self, forCellWithReuseIdentifier: IssueCommentReactionCell.reuse)
        return view
    }()
    private var reactions = [ReactionViewModel]()
    private var border: UIView? = nil
    private var queuedOperation: (content: ReactionContent, operation: IssueReactionOperation)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        addButton.tintColor = Styles.Colors.Gray.light.color
        addButton.setTitle("+", for: .normal)
        addButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        addButton.setTitleColor(Styles.Colors.Gray.light.color, for: .normal)
        addButton.semanticContentAttribute = .forceRightToLeft
        addButton.setImage(UIImage(named: "smiley-small")?.withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.addTarget(self, action: #selector(IssueCommentReactionCell.onAddButton), for: .touchUpInside)
        addButton.accessibilityLabel = NSLocalizedString("Add reaction", comment: "")
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.left.equalTo(Styles.Sizes.gutter)
            make.centerY.equalTo(contentView)
        }

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(addButton.snp.right).offset(Styles.Sizes.columnSpacing)
            make.top.bottom.right.equalTo(contentView)
        }

        border = contentView.addBorder(.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func perform(operation: IssueReactionOperation, content: ReactionContent) {
        // store the content:operation pair for next binding
        // implies that IGListBindingSectionController will do its thing, and this method is called
        // in sectionController(_, cellForViewModel:,at index:)
        queuedOperation = (content, operation)
    }

    func configure(borderVisible: Bool) {
        self.border?.isHidden = !borderVisible
    }

    // MARK: Private API

    func cell(for content: ReactionContent) -> IssueReactionCell? {
        guard let idx = reactions.index(where: { (model: ReactionViewModel) -> Bool in
            return model.content == content
        }) else { return nil }
        let path = IndexPath(item: idx, section: 0)
        return collectionView.cellForItem(at: path) as? IssueReactionCell
    }

    @objc private func onAddButton() {
        addButton.becomeFirstResponder()

        let actions = [
            (ReactionContent.thumbsUp.emoji, #selector(IssueCommentReactionCell.onThumbsUp)),
            (ReactionContent.thumbsDown.emoji, #selector(IssueCommentReactionCell.onThumbsDown)),
            (ReactionContent.laugh.emoji, #selector(IssueCommentReactionCell.onLaugh)),
            (ReactionContent.hooray.emoji, #selector(IssueCommentReactionCell.onHooray)),
            (ReactionContent.confused.emoji, #selector(IssueCommentReactionCell.onConfused)),
            (ReactionContent.heart.emoji, #selector(IssueCommentReactionCell.onHeart)),
        ]

        let menu = UIMenuController.shared
        menu.menuItems = actions.map { UIMenuItem(title: $0.0, action: $0.1) }
        menu.setTargetRect(addButton.imageView?.frame ?? .zero, in: addButton)
        menu.setMenuVisible(true, animated: true)
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
        delegate?.didToggle(cell: self, reaction: .thumbsUp)
    }

    @objc private func onThumbsDown() {
        delegate?.didToggle(cell: self, reaction: .thumbsDown)
    }

    @objc private func onLaugh() {
        delegate?.didToggle(cell: self, reaction: .laugh)
    }

    @objc private func onHooray() {
        delegate?.didToggle(cell: self, reaction: .hooray)
    }

    @objc private func onConfused() {
        delegate?.didToggle(cell: self, reaction: .confused)
    }

    @objc private func onHeart() {
        delegate?.didToggle(cell: self, reaction: .heart)
    }

    func configure(cell: IssueReactionCell, model: ReactionViewModel) {
        let users = model.users
        let detailText: String
        switch users.count {
        case 0:
            detailText = ""
        case 1:
            let format = NSLocalizedString("%@", comment: "")
            detailText = String.localizedStringWithFormat(format, users[0])
            break
        case 2:
            let format = NSLocalizedString("%@ and %@", comment: "")
            detailText = String.localizedStringWithFormat(format, users[0], users[1])
            break
        case 3:
            let format = NSLocalizedString("%@, %@ and %@", comment: "")
            detailText = String.localizedStringWithFormat(format, users[0], users[1], users[2])
            break
        default:
            let difference = model.count - users.count
            let format = NSLocalizedString("%@, %@, %@ and %d other(s)", comment: "")
            detailText = String.localizedStringWithFormat(format, users[0], users[1], users[2], difference)
            break
        }

        cell.configure(
            emoji: model.content.emoji,
            count: model.count,
            detail: detailText,
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
        let modifier = CGFloat(reactions[indexPath.item].count.description.count - 1)
        return CGSize(width: 50 + modifier * 5, height: collectionView.bounds.height)
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
