//
//  TextActionsController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class TextActionsController: NSObject,
    IssueTextActionsViewDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    ImageUploadDelegate {

    private weak var textView: UITextView?
    weak var viewController: UIViewController?
    private var client: GithubClient?

    // MARK: Public API

    func configure(client: GithubClient, textView: UITextView, actions: IssueTextActionsView) {
        self.client = client
        self.textView = textView
        actions.delegate = self
    }

    // MARK: IssueTextActionsViewDelegate

    func didSelect(actionsView: IssueTextActionsView, operation: IssueTextActionOperation) {
        switch operation.operation {
        case .execute(let block): block()
        case .wrap(let left, let right): textView?.replace(left: left, right: right, atLineStart: false)
        case .line(let left): textView?.replace(left: left, right: nil, atLineStart: true)
        case .uploadImage: displayUploadImage()
        }
    }

    // MARK: Image Upload

    func displayUploadImage() {
        guard let superview = textView?.superview else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        imagePicker.popoverPresentationController?.canOverlapSourceViewRect = true

        let sourceFrame = superview.frame
        let sourceRect = CGRect(origin: CGPoint(x: sourceFrame.midX, y: sourceFrame.minY), size: CGSize(width: 1, height: 1))
        imagePicker.popoverPresentationController?.sourceView = superview
        imagePicker.popoverPresentationController?.sourceRect = sourceRect
        imagePicker.popoverPresentationController?.permittedArrowDirections = .up

        viewController?.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }

        let username = client?.sessionManager.focusedUserSession?.username ?? Constants.Strings.unknown
        guard let uploadController = ImageUploadTableViewController.create(image, username: username, delegate: self) else { return }

        picker.pushViewController(uploadController, animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: ImageUploadDelegate

    func imageUploaded(link: String, altText: String) {
        textView?.replace(left: "![\(altText)](\(link))", right: nil, atLineStart: false)
    }

}
