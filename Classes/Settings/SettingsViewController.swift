//
//  SettingsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class SettingsViewController: UIViewController {

    let session: GithubSession

    init(
        session: GithubSession
        ) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
        session.addListener(listener: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

}

extension SettingsViewController: IGListAdapterDataSource {

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return []
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return IGListSectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }

}

extension SettingsViewController: GithubSessionListener {

    func didAdd(session: GithubSession, authorization: Authorization) {

    }

    func didRemove(session: GithubSession, authorization: Authorization) {

    }

}
