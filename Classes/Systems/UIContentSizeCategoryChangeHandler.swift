//
//  UIContentSizeCategoryChangeHandler.swift
//  Freetime
//
//  Created by Ivan Smetanin on 08/04/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class UIContentSizeCategoryChangeHandler {

    public static let shared = UIContentSizeCategoryChangeHandler()

    private init() {}

    func setup() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(contentSizeCategoryDidChange),
            name: .UIContentSizeCategoryDidChange,
            object: nil
        )
    }

    // MARK: Private API

    @objc private func contentSizeCategoryDidChange() {
        print("change")
        UIContentSizeCategory.preferred = UIContentSizeCategory.preferred
    }

}
