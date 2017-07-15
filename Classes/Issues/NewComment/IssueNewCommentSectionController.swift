//
//  IssueNewCommentSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueNewCommentSectionController: ListSectionController,
IssueNewCommentTextViewCellDelegate,
AddCommentListener {

    private static let minHeight: CGFloat = Styles.Sizes.tableCellHeight * 2

    private let client: AddCommentClient
    private var textHeight = IssueNewCommentSectionController.minHeight
    private var text = ""
    private var sending = false

    init(client: AddCommentClient) {
        self.client = client
        super.init()
        super.inset = Styles.Sizes.listInsetLarge
        client.addListener(listener: self)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        return CGSize(width: width, height: textHeight + IssueNewCommentTextViewCell.bottomBarHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: IssueNewCommentTextViewCell.self, for: self, at: index) as? IssueNewCommentTextViewCell
            else { fatalError("Missing context or cell wrong type") }
        cell.delegate = self
        cell.setSending(sending: sending)
        cell.configure(text)
        return cell
    }

    // MARK: IssueNewCommentTextViewCellDelegate

    func didChangeText(cell: IssueNewCommentTextViewCell, text: String) {
        self.text = text
    }

    func didChangeHeight(cell: IssueNewCommentTextViewCell, height: CGFloat) {
        let newHeight = max(height, IssueNewCommentSectionController.minHeight)
        guard newHeight != textHeight else { return }
        self.textHeight = newHeight
        self.collectionContext?.invalidateLayout(for: self)
    }

    func didTapSend(cell: IssueNewCommentTextViewCell) {
        guard text.characters.count > 0 else { return }
        sending = true
        cell.setSending(sending: true)
        client.addComment(body: text)
    }

    // MARK: AddCommentListener

    func didSendComment(client: AddCommentClient, id: String, commentFields: CommentFields, reactionFields: ReactionFields) {
        sending = false
        text = ""
        collectionContext?.performBatch(animated: true, updates: { batch in
            batch.reload(self)
        })
    }

    func didFailSendingComment(client: AddCommentClient) {
        guard let cell = collectionContext?.cellForItem(at: 0, sectionController: self) as? IssueNewCommentTextViewCell
            else { return }
        sending = false
        cell.setSending(sending: false)
    }

}
