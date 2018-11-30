//
//  RepositoryErrorViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import SnapKit
import XLPagerTabStrip

final class RepositoryErrorViewController: UIViewController,
IndicatorInfoProvider {

    private let emptyView = EmptyView()

    var delegate: EmptyViewDelegate? {
        get { return emptyView.delegate }
        set {
            emptyView.delegate = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Strings.overview
        emptyView.label.text = NSLocalizedString("There was an error loading the repository.", comment: "")
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: IndicatorInfoProvider

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: title)
    }

}
