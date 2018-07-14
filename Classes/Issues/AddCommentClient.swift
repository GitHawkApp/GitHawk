//
//  AddCommentClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Squawk

protocol AddCommentListener: class {
    func didSendComment(
        client: AddCommentClient,
        id: String,
        commentFields: CommentFields,
        reactionFields: ReactionFields,
        viewerCanUpdate: Bool,
        viewerCanDelete: Bool
    )
    func didFailSendingComment(client: AddCommentClient, subjectId: String, body: String)
}

final class AddCommentClient {

    private class ListenerWrapper: NSObject {
        weak var listener: AddCommentListener?
    }
    private var listeners = [ListenerWrapper]()
    private let client: GithubClient

    init(client: GithubClient) {
        self.client = client
    }

    // MARK: Public API

    func addListener(listener: AddCommentListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    func addComment(subjectId: String, body: String) {
        let bodyWithSignature = Signature.signed(text: body)

        let mutation = AddCommentMutation(subject_id: subjectId, body: bodyWithSignature)
        client.client.mutate(mutation, result: { data in
            data.addComment?.commentEdge.node
        }) { result in
            switch result {
            case .success(let commentNode):
                let fragments = commentNode.fragments
                for listener in self.listeners {
                    listener.listener?.didSendComment(
                        client: self,
                        id: fragments.nodeFields.id,
                        commentFields: fragments.commentFields,
                        reactionFields: fragments.reactionFields,
                        viewerCanUpdate: fragments.updatableFields.viewerCanUpdate,
                        viewerCanDelete: fragments.deletableFields.viewerCanDelete
                    )
                }
            case .failure:
                for listener in self.listeners {
                    listener.listener?.didFailSendingComment(client: self, subjectId: subjectId, body: body)
                }
                Squawk.showGenericError()
            }
        }
    }

}
