//
//  BookmarkIssueViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

struct BookmarkIssueViewModel: ListSwiftDiffable {

    // combining possible issue and PR states
    // https://developer.github.com/v4/enum/issuestate/
    // https://developer.github.com/v4/enum/pullrequeststate/
    enum State: String {
        case pending
        case closed = "CLOSED"
        case merged = "MERGED"
        case open = "OPEN"
    }

    let repo: Repository
    let number: Int
    let isPullRequest: Bool
    let state: State
    let text: StyledTextRenderer
    private let _identifier: String

    init(
        repo: Repository,
        number: Int,
        isPullRequest: Bool,
        state: State,
        text: StyledTextRenderer
        ) {
        self.repo = repo
        self.number = number
        self.isPullRequest = isPullRequest
        self.state = state
        self.text = text
        _identifier = "\(repo.owner).\(repo.name).\(number)"
    }

    init(
        owner: String,
        name: String,
        number: Int,
        isPullRequest: Bool,
        state: String,
        title: String
        ) {
        let string = StyledTextBuilder(
            styledText: StyledText(text: title, style: Styles.Text.body)
            ).build()
        self.init(
            repo: Repository(owner: owner, name: name),
            number: number,
            isPullRequest: isPullRequest,
            state: State(rawValue: state) ?? .pending,
            text: StyledTextRenderer(string: string, contentSizeCategory: .medium)
        )
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return _identifier
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? BookmarkIssueViewModel else { return false }
        return isPullRequest == value.isPullRequest
            && state == value.state
            && text.string == value.text.string
    }

}
