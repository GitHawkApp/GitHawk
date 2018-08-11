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
      switch (ReactionContent.defaultReaction)
      {
      case ReactionContent.thumbsUp:
        updateCells(cell: thumbsUpCell)
      case ReactionContent.thumbsDown:
        updateCells(cell: thumbsDownCell)
      case ReactionContent.laugh:
        updateCells(cell: laughCell)
      case ReactionContent.hooray:
        updateCells(cell: hoorayCell)
      case ReactionContent.confused:
        updateCells(cell: confusedCell)
      case ReactionContent.heart:
        updateCells(cell: heartCell)
      case ReactionContent.__unknown("Disabled"):
        enabledSwitch.isOn = false
      default:
        updateCells(cell: thumbsUpCell)
      }
      
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
        updateDefaultReaction(.thumbsUp)
      case thumbsDownCell:
        updateDefaultReaction(.thumbsDown)
      case laughCell:
        updateDefaultReaction(.laugh)
      case hoorayCell:
        updateDefaultReaction(.hooray)
      case confusedCell:
        updateDefaultReaction(.confused)
      case heartCell:
        updateDefaultReaction(.heart)
      default:
        break
      }
    }
  
    @IBAction func toggleDefaultReaction(_ sender: Any) {
        if(enabledSwitch.isOn) {
          updateDefaultReaction(.thumbsUp)
        } else {
          updateDefaultReaction(.__unknown("Disabled"))
        }
        updateSections()
    }
  
    private func updateDefaultReaction(_ reaction: ReactionContent) {
      UserDefaults.setDefault(reaction: reaction)
      checkCurrentDefault()
    }
  
    private func updateSections() {
      tableView.performBatchUpdates({
        if(enabledSwitch.isOn) {
          self.tableView.insertSections(IndexSet(integer: 1), with: .top)
        } else {
          self.tableView.deleteSections(IndexSet(integer: 1), with: .top)
        }
      }, completion: nil)
    }
}

