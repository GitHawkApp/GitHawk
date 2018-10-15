//
//  DefaultReactionSubController.swift
//  Freetime
//
//  Created by Ehud Adler on 8/5/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class DefaultReactionDetailController: UITableViewController {

    @IBOutlet var thumbsUpCell: UITableViewCell!
    @IBOutlet var thumbsDownCell: UITableViewCell!
    @IBOutlet var laughCell: UITableViewCell!
    @IBOutlet var hoorayCell: UITableViewCell!
    @IBOutlet var confusedCell: UITableViewCell!
    @IBOutlet var heartCell: UITableViewCell!
    @IBOutlet var enabledSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrentDefault()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return enabledSwitch.isOn ? 2 : 1
    }

    private func checkCurrentDefault() {
        guard let reaction = ReactionContent.defaultReaction else {
            enabledSwitch.isOn = false
            return
        }

        let cell: UITableViewCell
        switch reaction {
        case .thumbsUp, .__unknown: cell = thumbsUpCell
        case .thumbsDown: cell = thumbsDownCell
        case .laugh: cell = laughCell
        case .hooray: cell = hoorayCell
        case .confused: cell = confusedCell
        case .heart: cell = heartCell
        }
        updateCells(cell: cell)
    }

    private func updateCells(cell: UITableViewCell) {
        rz_smoothlyDeselectRows(tableView: self.tableView)

        // Reset all to none
        thumbsUpCell.accessoryType = .none
        thumbsDownCell.accessoryType = .none
        laughCell.accessoryType = .none
        hoorayCell.accessoryType = .none
        confusedCell.accessoryType = .none
        heartCell.accessoryType = .none

        // Set proper cell to check
        cell.accessoryType = .checkmark
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: trueUnlessReduceMotionEnabled)
        let cell = tableView.cellForRow(at: indexPath)

        switch cell {
        case thumbsUpCell:
            updateDefault(reaction: .thumbsUp)
        case thumbsDownCell:
            updateDefault(reaction: .thumbsDown)
        case laughCell:
            updateDefault(reaction: .laugh)
        case hoorayCell:
            updateDefault(reaction: .hooray)
        case confusedCell:
            updateDefault(reaction: .confused)
        case heartCell:
            updateDefault(reaction: .heart)
        default:
            break
        }
    }

    @IBAction func toggleDefaultReaction(_ sender: Any) {
        if enabledSwitch.isOn {
            updateDefault(reaction: .thumbsUp)
        } else {
            disableReaction()
        }
        updateSections()
    }

    private func updateDefault(reaction: ReactionContent) {
        UserDefaults.standard.setDefault(reaction: reaction)
        checkCurrentDefault()
    }

    private func disableReaction() {
        UserDefaults.standard.disableReaction()
    }

    private func updateSections() {
        tableView.performBatchUpdates({
            if enabledSwitch.isOn {
                self.tableView.insertSections(IndexSet(integer: 1), with: .top)
            } else {
                self.tableView.deleteSections(IndexSet(integer: 1), with: .top)
            }
        }, completion: nil)
    }
}
