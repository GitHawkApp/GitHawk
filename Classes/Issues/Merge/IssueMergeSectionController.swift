//
//  IssueMergeSectionController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeSectionController: ListBindingSectionController<IssueMergeModel>,
ListBindingSectionControllerDataSource,
MergeButtonDelegate {

    private let model: IssueDetailsModel
    private let client: GithubClient
    private let resultID: String?

    init(model: IssueDetailsModel, client: GithubClient, resultID: String?) {
        self.model = model
        self.client = client
        self.resultID = resultID
        super.init()
        dataSource = self
    }

    // MARK: Private API

    var preferredMergeTypeKey: String {
        return "com.freetime.IssueMergeSectionController.PreferredMergeType.\(model.repo).\(model.owner)"
    }

    var preferredMergeType: IssueMergeType {
        guard let type = IssueMergeType(rawValue: UserDefaults.standard.integer(forKey: preferredMergeTypeKey))
            else { return .merge }
        return type
    }

    func set(preferredMergeType: IssueMergeType) {
        UserDefaults.standard.set(preferredMergeType.rawValue, forKey: preferredMergeTypeKey)
    }

    func merge() {
        guard let id = resultID,
            let previous: IssueResult = client.cache.get(id: id)
            else { return }
        client.merge(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            type: preferredMergeType
        )
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        guard let object = self.object else { return [] }

        var viewModels = [ListDiffable]()

        if object.contexts.count > 0 {
            let states = object.contexts.map { $0.state }
            let state: IssueMergeSummaryModel.State
            let stateDescription: String
            let failureDescription = NSLocalizedString("Some checks failed", comment: "")
            let containsFailure = states.contains(.failure) || states.contains(.error)
            switch states {
            case _ where containsFailure:
                state = .failure
                stateDescription = failureDescription
            case let states where states.contains(.pending) && !containsFailure:
                state = .pending
                stateDescription = NSLocalizedString("Merge status pending", comment: "")
            case let states where states.reduce(true, { $0 && $1 == .success }):
                state = .success
                stateDescription = NSLocalizedString("All checks passed", comment: "")
            default:
                assert(false, "This should only occur when any of the `states` are of type `.expected`, which we have no clue of when it is used. The documentation (https://developer.github.com/v4/enum/statusstate/) doesn't answer that question either.")
                state = .failure
                stateDescription = failureDescription
            }
            
            viewModels.append(IssueMergeSummaryModel(title: stateDescription, state: state))
        }

        viewModels += object.contexts as [ListDiffable]

        let mergeable = object.state == .mergeable
        viewModels.append(IssueMergeSummaryModel(
            title: mergeable ?
                NSLocalizedString("No conflicts with base branch", comment: "")
                : NSLocalizedString("Merge conflicts found", comment: ""),
            state: mergeable ? .success : .warning
        ))

        viewModels.append(IssueMergeButtonModel(enabled: mergeable, type: preferredMergeType))

        return viewModels
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.insetContainerSize.width
            else { fatalError() }
        let height: CGFloat
        switch viewModel {
        case is IssueMergeButtonModel: height = Styles.Sizes.tableCellHeightLarge
        default: height = Styles.Sizes.tableCellHeight
        }
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell & ListBindable {
        let cellType: (UICollectionViewCell & ListBindable).Type
        switch viewModel {
        case is IssueMergeButtonModel: cellType = IssueMergeButtonCell.self
        case is IssueMergeSummaryModel: cellType = IssueMergeSummaryCell.self
        case is IssueMergeContextModel: cellType = IssueMergeContextCell.self
        default: fatalError()
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellType, for: self, at: index) as? UICollectionViewCell & ListBindable
            else { fatalError() }

        if let cell = cell as? IssueCommentBaseCell {
            cell.border = index == 0 ? .head : index == self.viewModels.count - 1 ? .tail : .neck
        }
        if let cell = cell as? IssueMergeButtonCell {
            cell.delegate = self
        }

        return cell
    }

    // MARK: MergeButtonDelegate

    func didSelect(button: MergeButton) {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Confirm merge", comment: ""),
            message: NSLocalizedString("Are you sure you want to merge this pull request?", comment: ""),
            preferredStyle: .alert
        )
        alert.addActions([
            AlertAction.cancel(),
            AlertAction(AlertActionBuilder {
                $0.title = NSLocalizedString("Merge", comment: "")
                $0.style = .default
            }).get { [weak self] _ in
                self?.merge()
            }
            ])
        viewController?.present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    func didSelectOptions(button: MergeButton) {
        let alert = UIAlertController.configured(preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = button.optionIconView

        for type in [IssueMergeType.merge, IssueMergeType.rebase, IssueMergeType.squash] {

            let title: String
            switch type {
            case .merge: title = NSLocalizedString("Merge", comment: "")
            case .rebase: title = NSLocalizedString("Rebase", comment: "")
            case .squash: title = NSLocalizedString("Squash", comment: "")
            }

            alert.add(action: AlertAction(AlertActionBuilder {
                $0.title = title
                $0.style = .default
            }).get { [weak self] _ in
                self?.set(preferredMergeType: type)
                self?.update(animated: true)
            })
        }

        alert.add(action: AlertAction.cancel())

        viewController?.present(alert, animated: trueUnlessReduceMotionEnabled)
    }

}
