//
//  SearchBarCell.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchBarCell: UICollectionViewCell, UISearchBarDelegate {

    weak var delegate: SearchBarSectionControllerDelegate?
    private let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.frame = frame
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = NSLocalizedString("Search Repositories", comment: "")
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        searchBar.backgroundColor = .clear
        contentView.addSubview(searchBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didFinishSearching(term: searchBar.text)
        contentView.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        contentView.endEditing(true)
    }
}
