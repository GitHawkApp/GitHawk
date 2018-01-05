//
//  AutocompleteController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import MessageViewController

final class AutocompleteController: NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    IssueCommentAutocompleteDelegate,
MessageAutocompleteControllerDelegate {

    let messageAutocompleteController: MessageAutocompleteController
    let autocomplete: IssueCommentAutocomplete

    init(
        messageAutocompleteController: MessageAutocompleteController,
        autocomplete: IssueCommentAutocomplete
        ) {
        self.messageAutocompleteController = messageAutocompleteController
        self.autocomplete = autocomplete

        super.init()

        for prefix in autocomplete.prefixes {
            messageAutocompleteController.register(prefix: prefix)
        }

        messageAutocompleteController.delegate = self

        let tableView = messageAutocompleteController.tableView
        tableView.delegate = self
        tableView.dataSource = self
        autocomplete.configure(tableView: tableView, delegate: self)
    }

    // MARK: MessageAutocompleteControllerDelegate

    func didFind(controller: MessageAutocompleteController, prefix: String, word: String) {
        autocomplete.didChange(tableView: controller.tableView, prefix: prefix, word: word)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocomplete.resultCount(prefix: messageAutocompleteController.selection?.prefix)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return autocomplete.cell(
            tableView: tableView,
            prefix: messageAutocompleteController.selection?.prefix,
            indexPath: indexPath
        )
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let accepted = autocomplete.accept(
            prefix: messageAutocompleteController.selection?.prefix,
            indexPath: indexPath
            ) {
            messageAutocompleteController.accept(autocomplete: accepted + " ", keepPrefix: false)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autocomplete.cellHeight
    }

    // MARK: IssueCommentAutocompleteDelegate

    func didChangeStore(autocomplete: IssueCommentAutocomplete) {
        for prefix in autocomplete.prefixes {
            messageAutocompleteController.register(prefix: prefix)
        }
        messageAutocompleteController.tableView.reloadData()
    }

    func didFinish(autocomplete: IssueCommentAutocomplete, hasResults: Bool) {
        messageAutocompleteController.show(hasResults)
    }

}

