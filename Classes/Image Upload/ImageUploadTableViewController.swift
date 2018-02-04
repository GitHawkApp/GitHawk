//
//  ImageUploadTableViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 14/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import MessageViewController

protocol ImageUploadDelegate: class {
    func imageUploaded(link: String, altText: String)
}

class ImageUploadTableViewController: UITableViewController {

    @IBOutlet private var previewImageView: UIImageView! {
        didSet {
            guard #available(iOS 11, *) else { return }
            previewImageView.accessibilityIgnoresInvertColors = true
        }
    }
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var bodyTextView: MessageTextView!
    
    private var bodyPlaceholder: String?
    private var bodyTextColor: UIColor?

    private var image: UIImage! // Set through the create function
    private var username: String?
    private weak var delegate: ImageUploadDelegate?

    private var compressionData: String?
    private lazy var client = ImgurClient()

    private var titleText: String? {
        guard let raw = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        if raw.isEmpty { return nil }
        return raw
    }

    private var descriptionText: String? {
        let raw = bodyTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if raw.isEmpty { return nil }
        return raw
    }

    class func create(_ image: UIImage, username: String?, delegate: ImageUploadDelegate) -> ImageUploadTableViewController? {
        let storyboard = UIStoryboard(name: "ImageUpload", bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController() as? ImageUploadTableViewController else {
            return nil
        }

        viewController.image = image
        viewController.username = username
        viewController.delegate = delegate

        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the preview image
        previewImageView.image = image

        // Set title field delegate so return moves to next field
        titleTextField.delegate = self

        // Set the right button item to spinning until we have compression info
        setRightBarItemSpinning()

        // Set the left button item to cancel
        setLeftBarItem()

        // Setup view colors and styles
        let placeholderText = NSLocalizedString("Optional", comment: "")
        bodyTextView.placeholderText = placeholderText
        bodyTextView.placeholderTextColor = Styles.Colors.Gray.light.color
        bodyTextView.font = Styles.Text.body.preferredFont
        bodyTextView.textContainerInset = .zero
        bodyTextView.textContainer.lineFragmentPadding = 0
        
        titleTextField.textColor = Styles.Colors.Gray.dark.color
        titleTextField.font = Styles.Text.body.preferredFont
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.light.color,
                .font: Styles.Text.body.preferredFont
            ]
        )
        
        // Compress and encode the image in the background to speed up the upload process
        image.compressAndEncode { [weak self] result in
            switch result {
            case .error:
                ToastManager.showError(message: NSLocalizedString("Failed to encode image", comment: ""))
                self?.navigationItem.rightBarButtonItem = nil
            case .success(let base64):
                self?.compressionData = base64

                DispatchQueue.main.async {
                    // Add a tick button as the right button item so the user can now upload
                    self?.setRightBarItemIdle()
                }
            }
        }
    }

    // MARK: Navigation Bar

    /// Sets the right bar button item to have a checkmark, enabling the user to upload the image
    private func setRightBarItemIdle() {
        let item = UIBarButtonItem(
            title: Constants.Strings.upload,
            style: .done,
            target: self,
            action: #selector(didPressUpload)
        )

        item.tintColor = Styles.Colors.Blue.medium.color
        navigationItem.rightBarButtonItem = item
    }

    private func setLeftBarItem() {
        let item = UIBarButtonItem(
            title: Constants.Strings.cancel,
            style: .plain,
            target: self,
            action: #selector(didPressCancel)
        )

        item.tintColor = Styles.Colors.Blue.medium.color
        navigationItem.leftBarButtonItem = item
    }

    @IBAction func didPressCancel() {
        let dismissBlock = {
            self.dismiss(animated: trueUnlessReduceMotionEnabled)
        }

        if titleText == nil && descriptionText == nil {
            dismissBlock()
            return
        }

        let title = NSLocalizedString("Unsaved Changes", comment: "Image Upload - Dismiss w/ Unsaved Changes Title")
        let message = NSLocalizedString("Are you sure you don't want to upload this image? Your title & description will not be saved!", comment: "Image Upload - Cancel w/ Dismiss Changes Message")

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addActions([
            AlertAction.goBack(),
            AlertAction.discard { _ in
                dismissBlock()
            }
        ])

        present(alert, animated: trueUnlessReduceMotionEnabled)
    }

    @IBAction func didPressUpload() {
        // Set the right bar item back to the spinner so they can't spam the button, and to indicate something is happening
        setRightBarItemSpinning()

        // Should never caught in here as the button will be disabled in this situation
        guard let compressionData = compressionData else {
            ToastManager.showGenericError()
            return
        }

        // Check that we have enough "tokens" to actually upload the image
        client.canUploadImage { [weak self] error in
            // Ensure that we do have enough tokens, otherwise remove the upload button
            if let error = error as? ImgurClient.ImgurError {
                
                switch error {
                case .endpointError(let response):
                    ToastManager.showError(message: response)
                    
                case .rateLimitExceeded:
                    ToastManager.showError(message: NSLocalizedString("Rate Limit reached, cannot upload!", comment: ""))
                    
                default:
                    ToastManager.showGenericError()
                }
                
                self?.navigationItem.rightBarButtonItem = nil
                return
            }

            var name = "GitHawk Upload"

            if let username = self?.username {
                name += " by \(username)"
            }

            // Ensure the upload step is on the background thread
            self?.client.uploadImage(
                base64Image: compressionData,
                name: name,
                title: self?.titleText ?? "",
                description: self?.descriptionText ?? "") { [weak self] result in

                switch result {
                case .error:
                    ToastManager.showGenericError()
                    self?.setRightBarItemIdle()

                case .success(let link):
                    self?.delegate?.imageUploaded(link: link, altText: name)
                    self?.dismiss(animated: trueUnlessReduceMotionEnabled)
                }

            }
        }
    }
    
    @IBAction func didPressPreviewImage() {
        let previewViewController = NYTPhotosViewController(photos: [IssueCommentPhoto(image: image, data: nil)])
        present(previewViewController, animated: trueUnlessReduceMotionEnabled)
    }
}

// MARK: UITextFieldDelegate

extension ImageUploadTableViewController: UITextFieldDelegate {
    /// Called when the user taps return on the title field, moves their cursor to the body
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyTextView.becomeFirstResponder()
        return false
    }
}
