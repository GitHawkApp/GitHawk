//
//  InboxFilterController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import ContextMenu

protocol InboxFilterControllerClient {
    func fetchSubscriptions(completion: @escaping (Result<[RepositoryDetails]>) -> Void)
}

protocol InboxFilterControllerListener: class {
    func didUpdateSelectedFilter(for controller: InboxFilterController)
}

final class InboxFilterController {

    let client: InboxFilterControllerClient
    let announcer = Announcer<InboxFilterControllerListener>()
    private static let key = "com.freetime.InboxFilterController.filterIndex"
    
    private static var filterIndex: Int {
        get { return UserDefaults.standard.integer(forKey: key) }
        set(newIndex) { UserDefaults.standard.set(newIndex, forKey: key) }
    }
    
    private static let filters = [
        InboxFilterModel(type: .unread),
        InboxFilterModel(type: .all),
        InboxFilterModel(type: .mentioned),
        InboxFilterModel(type: .assigned),
        InboxFilterModel(type: .created)
    ]

    private(set) var selected: InboxFilterModel = InboxFilterController.filters[filterIndex] {
        didSet {
            announcer.enumerate { $0.didUpdateSelectedFilter(for: self) }
            guard let newIndex = InboxFilterController.filters
                .firstIndex(where: { $0.type == selected.type }) else { return }
            InboxFilterController.filterIndex = newIndex
        }
    }
    private var fetchedFilters = [InboxFilterModel]()

    init(client: InboxFilterControllerClient) {
        self.client = client
    }

    func update(selection: InboxFilterModel) {
        selected = selection
    }

    private func selected(model: InboxFilterModel) {
        selected = model
    }

    private func showRepos(from viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        ContextMenu.shared.show(
            sourceViewController: viewController,
            viewController: InboxFilterReposViewController(inboxFilterController: self),
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    backgroundColor: Styles.Colors.menuBackgroundColor.color
                )
            )
        )
    }

    func showMenu(from viewController: UIViewController) {
        var items: [ContrastContextMenuItem] = InboxFilterController.filters.map { model in
            ContrastContextMenuItem(
                title: model.type.title,
                iconName: model.type.iconName,
                iconColor: Styles.Colors.Blue.menu.color,
                separator: false,
                action: { [weak self] menu in
                    menu.dismiss(animated: trueUnlessReduceMotionEnabled)
                    self?.selected(model: model)
            })
        }
        items.append(ContrastContextMenuItem(
            title: NSLocalizedString("Repos", comment: ""),
            iconName: "repo",
            iconColor: Styles.Colors.Blue.menu.color,
            separator: true,
            action: { [weak self, weak viewController] menu in
                menu.dismiss(animated: trueUnlessReduceMotionEnabled)
                self?.showRepos(from: viewController)
        }))

        ContextMenu.shared.show(
            sourceViewController: viewController,
            viewController: ContrastContextMenu(items: items),
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    backgroundColor: Styles.Colors.menuBackgroundColor.color
                ),
                menuStyle: .minimal,
                hapticsStyle: .medium,
                position: .centerX
            ),
            sourceView: viewController.navigationItem.titleView
        )
    }

}
