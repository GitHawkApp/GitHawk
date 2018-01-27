//
//  main.swift
//  FreetimeUITests
//
//  Created by Ryan Nystrom on 1/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit

enum AppReset {
    static func resetKeychain() {
        let secClasses = [
            kSecClassGenericPassword as String,
            kSecClassInternetPassword as String,
            kSecClassCertificate as String,
            kSecClassKey as String,
            kSecClassIdentity as String
        ]
        for secClass in secClasses {
            let query = [kSecClass as String: secClass]
            SecItemDelete(query as CFDictionary)
        }
    }
    static func resetUserDefaults() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
    }
}

_ = autoreleasepool {

    print("PROCESS INFO ARGS")
    print(ProcessInfo().arguments)
    print("END process info args")
    if ProcessInfo.processInfo.arguments.contains("--reset") {
        AppReset.resetKeychain()
        AppReset.resetUserDefaults()
    }

    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to:
            UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(AppDelegate.self)
    )
}
