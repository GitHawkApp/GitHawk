//
//  UIApplication+SafeShared.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 05/01/2018.
//  Copyright © 2018 Merrick Sapsford. All rights reserved.
//

import Foundation

internal extension UIApplication {
    
    static var safeShared: UIApplication? {
        guard #available(iOSApplicationExtension 8, *) else {
            return nil
        }
        
        guard UIApplication.responds(to: NSSelectorFromString("sharedApplication")),
            let unmanagedSharedApplication = UIApplication.perform(NSSelectorFromString("sharedApplication")) else {
            return nil
        }
        
        return unmanagedSharedApplication.takeUnretainedValue() as? UIApplication
    }
}
