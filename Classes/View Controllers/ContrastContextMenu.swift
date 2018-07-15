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
        view.backgroundColor = Styles.Colors.blueGray.color
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = Styles.Sizes.tableCellHeight
        tableView.separatorColor = Styles.Colors.Gray.medium.color
        tableView.reloadData()
        tableView.layoutIfNeeded()
        preferredContentSize = tableView.contentSize
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectedBackgroundView?.backgroundColor = .red

        cell.textLabel?.font = Styles.Text.secondaryBold.preferredFont
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = item.title

        if let iconName = item.iconName {
            cell.imageView?.tintColor = Styles.Colors.Blue.medium.color
            cell.imageView?.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        }

        cell.separatorInset = UIEdgeInsets(
            top: 0,
            left: item.separator ? 0 : UIScreen.main.bounds.width,
            bottom: 0,
            right: 0
        )

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].action?(self)
    }

}
