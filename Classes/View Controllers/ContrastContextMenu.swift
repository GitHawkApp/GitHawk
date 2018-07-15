//
//  ContrastContextMenu.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

struct ContrastContextMenuItem {
    
    let title: String
    let iconName: String?
    let separator: Bool
    let action: ((ContrastContextMenu) -> Void)?

    init(
        title: String,
        iconName: String? = nil,
        separator: Bool = false,
        action: ((ContrastContextMenu) -> Void)? = nil
        ) {
        self.title = title
        self.iconName = iconName
        self.separator = separator
        self.action = action
    }

}

final class ContrastContextMenu: UITableViewController {

    private class Cell: UITableViewCell {
        static let reuseIdentifier = "cell"
        var border: UIView? = nil
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            selectedBackgroundView = UIView()
            selectedBackgroundView?.backgroundColor = Styles.Colors.Gray.medium.color
            contentView.backgroundColor = nil
            backgroundColor = nil

            textLabel?.font = Styles.Text.bodyBold.preferredFont
            textLabel?.textColor = .white

            imageView?.tintColor = Styles.Colors.Blue.medium.color

            border = contentView.addBorder(.top)
            border?.backgroundColor = Styles.Colors.Gray.medium.color
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    private let items: [ContrastContextMenuItem]

    init(items: [ContrastContextMenuItem]) {
        self.items = items
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.rowHeight = Styles.Sizes.tableCellHeight
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
        preferredContentSize = CGSize(width: 180, height: tableView.contentSize.height)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = item.title
        if let iconName = item.iconName {
            cell.imageView?.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        }

        if let cell = cell as? Cell {
            cell.border?.isHidden = !item.separator
        }

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].action?(self)
    }

}
