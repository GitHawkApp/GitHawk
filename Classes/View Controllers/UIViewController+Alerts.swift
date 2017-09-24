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
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        alert.addAction(action)
		alert.view.tintColor = Styles.Colors.Blue.medium.color
        present(alert, animated: true, completion: nil)
    }

}
