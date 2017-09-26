//
//  Alerts.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String) {
		let alert = UIAlertController.configured(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

extension UIAlertController {
	
	static func configured(title: String? = nil, message: String? = nil, preferredStyle: UIAlertControllerStyle) -> UIAlertController {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
		alertController.view.tintColor = Styles.Colors.Blue.medium.color
		return alertController
	}
}
