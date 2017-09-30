//
//  ImageUploadViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 30/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol ImageUploadDelegate: class {
    func imageUploaded(link: String, altText: String)
}

class ImageUploadViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextView!
    
    var image: UIImage! // Set through the create function
    var username: String?
    weak var delegate: ImageUploadDelegate?
    
    var compressionData: String?
    lazy var client = ImgurClient()
    
    private var titleText: String? {
        guard let raw = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
        if raw.isEmpty { return nil }
        return raw
    }
    
    private var descriptionText: String? {
        let raw = bodyTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if raw.isEmpty { return nil }
        return raw
    }
    
    class func create(_ image: UIImage, username: String?, delegate: ImageUploadDelegate) -> UINavigationController? {
        let storyboard = UIStoryboard(name: "ImageUpload", bundle: nil)
        
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        if let uploadVc = navController.topViewController as? ImageUploadViewController {
            uploadVc.image = image
            uploadVc.username = username
            uploadVc.delegate = delegate
        }
        
        return navController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the preview image
        previewImageView.image = image
        
        // Set title field delegate so return moves to next field
        titleTextField.delegate = self
        
        // Add borders to imitate UITableView grouped design
        titleTextField.superview?.addBorder(.bottom)
        titleTextField.superview?.addBorder(.top)
        bodyTextField.superview?.addBorder(.bottom)
        bodyTextField.superview?.addBorder(.top)
        
        // Set the right button item to spinning until we have compression info
        setRightBarItemSpinning()
        
        // Compres and encode the image in the background to speed up the upload process
        client.compressAndEncodeImage(image, completion: { [weak self] result in
            switch result {
            case .error:
                StatusBar.showError(message: NSLocalizedString("Failed to encode image", comment: ""))
            case .success(let base64):
                self?.compressionData = base64
                
                DispatchQueue.main.async {
                    // Add a tick button as the right button item so the user can now upload
                    self?.setRightBarItemIdle()
                }
            }
        })
    }
    
    // MARK: Navigation Bar
    
    private func setRightBarItemSpinning() {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
    }
    
    private func setRightBarItemIdle() {
        let item = UIBarButtonItem(
            image: UIImage(named: "check"),
            style: .plain,
            target: self,
            action: #selector(didPressTick)
        )
        
        item.tintColor = Styles.Colors.Green.medium.color
        item.accessibilityLabel = NSLocalizedString("Upload", comment: "")
        navigationItem.rightBarButtonItem = item
    }

    @IBAction func didPressClose() {
        let dismissBlock = {
            self.dismiss(animated: true)
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
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didPressTick() {
        // Set the right bar item back to the spinner so they can't spam the button, and to indicate something is happening
        setRightBarItemSpinning()
        
        // Should never caught in here as the button will be disabled in this situation
        guard let compressionData = compressionData else {
            StatusBar.showGenericError()
            return
        }
        
        // Check that we have enough "tokens" to actually upload the image
        client.canUploadImage { [weak self] success in
            guard success else {
                StatusBar.showError(message: NSLocalizedString("Rate Limit reached, cannot upload!", comment: ""))
                return
            }
            
            var name = "GitHawk Upload"
            
            if let username = self?.username {
                name += " by \(username)"
            }
            
            self?.client.uploadImage(
                base64: compressionData,
                name: name,
                title: self?.titleText ?? "",
                description: self?.descriptionText ?? "") { [weak self] result in
                    
                DispatchQueue.main.async {
                    switch result {
                    case .error:
                        StatusBar.showGenericError()
                        self?.setRightBarItemIdle()
                        return
                    case .success(let link):
                        self?.delegate?.imageUploaded(link: link, altText: name)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    
    /// Called when the user taps return on the title field, moves their cursor to the body
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bodyTextField.becomeFirstResponder()
        return false
    }

}
