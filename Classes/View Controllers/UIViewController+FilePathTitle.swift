//
//  UIViewController+FilePathTitle.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func configureTitle(filePath: FilePath, target: Any, action: Selector) {
        let accessibilityLabel: String?
        switch (filePath.current, filePath.basePath) {
        case (.some(let current), .some(let basePath)):
            let isCurrentAFile = filePath.fileExtension != nil
            let currentType = isCurrentAFile ? "File" : "Folder"
            accessibilityLabel = .localizedStringWithFormat("%@: %@, file path: %@", currentType, current, basePath)
        case (.some(let current), .none):
            // NOTE: This is currently unused, as we early-exit
            // and set the navigationItem's title, but not it's titleView -
            // and thus we can't set an accessibility label.
            let isFile = filePath.fileExtension != nil
            let type = isFile ? "File" : "File path"
            accessibilityLabel = .localizedStringWithFormat("%@: %@", type, current)
        case (.none, .some(let basePath)):
            assert(false, "We should never have just a base path; this should always be accompanied by a current path!")
            accessibilityLabel = .localizedStringWithFormat("File path: %@", basePath)
        case (.none, .none):
            accessibilityLabel = nil
        }

        let navigationTitle = NavigationTitleDropdownView()
        navigationTitle.configure(title: filePath.current, subtitle: filePath.basePath, accessibilityLabel: accessibilityLabel)
        navigationTitle.addTarget(target, action: action, for: .touchUpInside)
        navigationItem.titleView = navigationTitle
    }

    private func popFileViewControllers(count: Int) {
        guard let children = navigationController?.viewControllers,
            count < children.count
            else { return }
        navigationController?.setViewControllers(Array(children[0..<children.count-count]), animated: true)
    }

    func showAlert(filePath: FilePath, sender: UIView) {
        let alertTitle = NSLocalizedString("Jump to...", comment: "Alert sheet title to jump to a filepath")
        let alert = UIAlertController.configured(title: alertTitle, preferredStyle: .actionSheet)
        weak var weakSelf = self

        if let components = filePath.baseComponents {
            for (i, component) in components.reversed().enumerated() {
                alert.addAction(UIAlertAction(
                    title: component,
                    style: .default,
                    handler: { _ in
                        weakSelf?.popFileViewControllers(count: i + 1)
                }))
            }
        }
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Root", comment: ""),
            style: .default,
            handler: { _ in
                weakSelf?.popFileViewControllers(count: filePath.components.count)
        }))
        alert.addAction(UIAlertAction(title: Constants.Strings.cancel, style: .cancel))
        alert.popoverPresentationController?.setSourceView(sender)
        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

}
