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
    private var loading = false

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
        // repo must have at least one merge method
        guard let availableTypes = self.object?.availableTypes, availableTypes.count > 0 else {
            return .merge
        }

        // make sure serialized type exists in repo spec. repo settings can change after pref is set.
        guard let type = IssueMergeType(rawValue: UserDefaults.standard.integer(forKey: preferredMergeTypeKey)),
            availableTypes.contains(type) else {
                return availableTypes[0]
        }
        return type
    }

    func set(preferredMergeType: IssueMergeType) {
        UserDefaults.standard.set(preferredMergeType.rawValue, forKey: preferredMergeTypeKey)
    }

    func merge() {
        guard let id = resultID,
            let previous: IssueResult = client.cache.get(id: id)
            else { return }
        loading = true
        update(animated: true)

        client.merge(
            previous: previous,
            owner: model.owner,
            repo: model.repo,
            number: model.number,
            type: preferredMergeType,
            error: { [weak self] in
                self?.loading = false
                self?.update(animated: true)
        })
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
            let (state, stateDescription) = MergeHelper.combinedMergeStatus(for: states)
            
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

        viewModels.append(IssueMergeButtonModel(
            enabled: mergeable,
            type: preferredMergeType,
            loading: loading
        ))

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
        guard let types = self.object?.availableTypes, types.count > 0 else { return }

        let alert = UIAlertController.configured(
            title: NSLocalizedString("Change merge type", comment: ""),
            preferredStyle: .actionSheet
        )
        alert.popoverPresentationController?.sourceView = button.optionIconView

        for type in types {
            alert.add(action: AlertAction(AlertActionBuilder {
                $0.title = type.localized
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
