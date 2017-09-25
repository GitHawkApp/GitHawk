//
//  AlertActions.swift
//  Freetime
//
//  Created by Ivan Magda on 25/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

struct AlertActions {
    
    static func share(_ items: [Any],
                      activities: [UIActivity]?,
                      controller: UIViewController,
                      sender: UIBarButtonItem) -> UIAlertAction {
        weak var weakController = controller
        
        return UIAlertAction(title: NSLocalizedString("Send To", comment: ""), style: .default) { _ in
            guard let strongController = weakController else {
                return
            }
            
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: activities)
            activityController.popoverPresentationController?.barButtonItem = sender
            
            strongController.present(activityController, animated: true)
        }
    }
    
}

