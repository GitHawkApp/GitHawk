//
//  NotificationsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import FlatCache
import Squawk
import DropdownTitleView
import ContextMenu

final class NotificationsViewController: BaseListViewController<Int>,
BaseListViewControllerDataSource,
FlatCacheListener,
TabNavRootViewControllerType,
BaseListViewControllerEmptyDataSource,
NewFeaturesSectionControllerDelegate,
InboxFilterControllerListener {

    private let modelController: NotificationModelController
    private var modelIDs = [String]()
    private var newFeaturesController: NewFeaturesController? = NewFeaturesController()
    private let inboxFilterController: InboxFilterController
    private let navigationTitle = DropdownTitleView()

    private var notifications: [NotificationViewModel] {
        return modelIDs.compactMap { modelController.githubClient.cache.get(id: $0) }
    }

    init(modelController: NotificationModelController) {
        self.modelController = modelController
        self.inboxFilterController = InboxFilterController(client: modelController.githubClient)

        super.init(
            emptyErrorMessage: NSLocalizedString("Cannot load your inbox.", comment: ""),
            backgroundThreshold: 5 * 60
        )

        self.dataSource = self
        self.emptyDataSource = self

        inboxFilterController.announcer.add(listener: self)
        updateTitle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBackBarItemEmpty()
        resetRightBarItem()

        navigationController?.tabBarItem.badgeColor = Styles.Colors.Red.medium.color
        navigationItem.titleView = navigationTitle
        navigationTitle.addTouchEffect()
        navigationTitle.titleFont = UIFont.preferredFont(forTextStyle: .headline)
        navigationTitle.addTarget(self, action: #selector(onNavigationTitle), for: .touchUpInside)
        // @ Fetches for new features
        newFeaturesController?.fetch { [weak self] in
            self?.update()
        }
    }

    override func fetch(page: Int?) {
        let type = inboxFilterController.selected.type
        let width = view.safeContentWidth(with: feed.collectionView)
        let fetchPage = page ?? 1
        // append model ids if paging
        let append = page != nil
        // do not animate paged updates, only head loads
        let animated = page == nil && trueUnlessReduceMotionEnabled

        switch type {
        case .unread, .all, .repo:

            let repo: Repository?
            if case .repo(let owner, let name) = type {
                repo = Repository(owner: owner, name: name)
            } else {
                repo = nil
            }

            modelController.fetchNotifications(
                repo: repo,
                // always fetch all for repos, otherwise use selection
                all: repo != nil || type == .all,
                page: fetchPage,
                width: width
            ) { [weak self] result in
                self?.handle(result: result, append: append, animated: animated, page: fetchPage)
            }
        case .assigned:
            modelController.fetch(for: .assigned, page: fetchPage, width: width) { [weak self] result in
                self?.handle(result: result, append: append, animated: animated, page: fetchPage)
            }
        case .created:
            modelController.fetch(for: .created, page: fetchPage, width: width) { [weak self] result in
                self?.handle(result: result, append: append, animated: animated, page: fetchPage)
            }
        case .mentioned:
            modelController.fetch(for: .mentioned, page: fetchPage, width: width) { [weak self] result in
                self?.handle(result: result, append: append, animated: animated, page: fetchPage)
            }
        }
    }

    private func handle<T: Cachable>(
        result: Result<([T], Int?)>,
        append: Bool,
        animated: Bool,
        page: Int
        ) {
        switch result {
        case .success(let models, let next):
            var ids = [String]()
            models.forEach {
                modelController.githubClient.cache.add(listener: self, value: $0)
                ids.append($0.id)
            }
            rebuildAndUpdate(ids: ids, append: append, page: next, animated: animated)
        case .error(let err):
            error(animated: trueUnlessReduceMotionEnabled)
            Squawk.show(error: err)
        }

        // set after updating so self.models has already been changed
        updateUnreadState()
    }

    private func updateUnreadState() {
        var unread = 0
        for id in modelIDs {
            guard let model = modelController.githubClient.cache.get(id: id) as NotificationViewModel?,
                !model.read
                else { continue }
            unread += 1
        }

        let hasUnread = unread > 0
        navigationItem.rightBarButtonItem?.isEnabled = hasUnread
        navigationController?.tabBarItem.badgeValue = hasUnread ? "\(unread)" : nil
        BadgeNotifications.updateBadge(count: unread)
    }

    func resetRightBarItem(updatingState updateState: Bool = true) {
        let item = UIBarButtonItem(
            image: UIImage(named: "check"),
            style: .plain,
            target: self,
            action: #selector(onMarkAll)
        )
        item.accessibilityLabel = NSLocalizedString("Mark notifications read", comment: "")
        navigationItem.rightBarButtonItem = item
        if updateState {
            updateUnreadState()
        }
    }

    @objc private func onMarkAll() {
        let type = inboxFilterController.selected.type
        let message: String
        switch type {
        case .unread, .all:
            message = NSLocalizedString("Mark all notifications as read?", comment: "")
        case .assigned, .created, .mentioned:
            message = NSLocalizedString(
                "Mark all notifications as read? This includes notifications not currently visible.",
                comment: ""
            )
        case let .repo(owner, name):
            let messageFormat = NSLocalizedString("Mark %@/%@ notifications as read?", comment: "")
            message = String(format: messageFormat, owner, name)
        }

        let alert = UIAlertController.configured(
            title: NSLocalizedString("Notifications", comment: ""),
            message: message,
            preferredStyle: .alert
        )

        alert.addActions([
            UIAlertAction(
                title: Constants.Strings.markRead,
                style: .destructive,
                handler: { [weak self] _ in
                    self?.markRead(type: type)
            }),
            AlertAction.cancel()
            ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    private func markRead(type: InboxFilterModel.FilterType) {
        self.setRightBarItemSpinning()

        let block: (Bool) -> Void = { success in
            let generator = UINotificationFeedbackGenerator()
            if success {
                generator.notificationOccurred(.success)

                // clear all badges
                BadgeNotifications.updateBadge(count: 0)

                // change the spinner to the mark all item
                // don't update state here; it is managed by `fetch`
                self.resetRightBarItem(updatingState: false)
            } else {
                generator.notificationOccurred(.error)
            }
            self.fetch(page: nil)

            // "mark all" is an engaging action, system prompt on it
            RatingController.prompt(.system)
        }

        switch type {
        case .unread, .all, .assigned, .created, .mentioned:
            modelController.markAllNotifications(completion: block)
        case let .repo(owner, name):
            modelController.markRepoNotifications(owner: owner, name: name, completion: block)
        }
    }

    private func rebuildAndUpdate(
        ids: [String],
        append: Bool,
        page: Int?,
        animated: Bool
        ) {
        if append {
            modelIDs += ids
        } else {
            modelIDs = ids
        }
        update(page: page, animated: animated)
    }

    private func updateTitle() {
        navigationTitle.configure(
            title: inboxFilterController.selected.type.title,
            subtitle: inboxFilterController.selected.type.subtitle
        )
    }

    @objc private func onNavigationTitle() {
        inboxFilterController.showMenu(from: self)
    }

    // MARK: BaseListViewControllerDataSource

    func models(adapter: ListSwiftAdapter) -> [ListSwiftPair] {
        var models = [ListSwiftPair]()

        if let markdown = newFeaturesController?.latestMarkdown {
            models.append(ListSwiftPair.pair(markdown, { [weak self] in
                NewFeaturesSectionController(delegate: self)
            }))
        }

        models += modelIDs.compactMap { id in
            if let model = modelController.githubClient.cache.get(id: id) as NotificationViewModel? {
                return ListSwiftPair.pair(model) { [modelController] in
                    NotificationSectionController(modelController: modelController)
                }
            } else if let model = modelController.githubClient.cache.get(id: id) as InboxDashboardModel? {
                return ListSwiftPair.pair(model) {
                    InboxDashboardSectionController()
                }
            }
            return nil
        }

        return models
    }

    // MARK: BaseListViewControllerEmptyDataSource

    func emptyModel(for adapter: ListSwiftAdapter) -> ListSwiftPair {
        let layoutInsets = view.safeAreaInsets
        return ListSwiftPair.pair("empty-notification-value", {
            return NoNewNotificationSectionController(layoutInsets: layoutInsets)
        })
    }

    // MARK: FlatCacheListener

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        self.update(animated: trueUnlessReduceMotionEnabled)
        updateUnreadState()
    }

    // MARK: TabNavRootViewControllerType

    func didSingleTapTab() {
        feed.collectionView.scrollToTop(animated: true)
    }

    func didDoubleTapTab() {
        didSingleTapTab()
    }

    // MARK: NewFeaturesSectionControllerDelegate

    func didTapClose(for sectionController: NewFeaturesSectionController) {
        newFeaturesController = nil
        update()
    }

    // MARK: InboxFilterControllerListener

    func didUpdateSelectedFilter(for controller: InboxFilterController) {
        updateTitle()
        feed.refreshHead()
    }

}
