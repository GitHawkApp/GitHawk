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
    @IBOutlet var noneCell: UITableViewCell!
  
    // let reactionList
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrentDefault()
    }
  
    private func checkCurrentDefault() {
      print(ReactionContent.defaultReaction)
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
        updateCells(cell: noneCell)
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
      noneCell.accessoryType = .none
      
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
      case noneCell:
        updateDefaultReaction(.__unknown("Disabled"))
      default:
        break
      }
    }
      
    func updateDefaultReaction(_ reaction: ReactionContent) {
      UserDefaults.setDefault(reaction: reaction)
      checkCurrentDefault()
    }

}

