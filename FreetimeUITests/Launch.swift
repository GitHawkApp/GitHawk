//
//  Launch.swift
//  FreetimeUITests
//
//  Created by Ryan Nystrom on 1/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
import Foundation

extension XCTestCase {

    enum LaunchOption: String {
        case reset = "--reset"
        case mockUser = "--mock-user"
    }

    func forwardEnvironment(variables: [String]) -> [String: String] {
        let env = ProcessInfo.processInfo.environment
        var forward = [String: String]()
        for variable in variables {
            forward[variable] = env[variable]
        }
        return forward
    }

    func launch(options: [LaunchOption]) {
        let app = XCUIApplication()
        app.launchArguments = ["--network-playback"] + options.map { $0.rawValue }
        app.launchEnvironment = forwardEnvironment(variables: [
            "GITHUB_CLIENT_SECRET",
            "GITHUB_CLIENT_ID",
            "IMGUR_CLIENT_ID",
            "NETWORK_RECORD_PATH",
            ])
        app.launch()
    }

}
