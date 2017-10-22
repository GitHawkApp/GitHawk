//
//  SearchBarCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchBarCellDelegate: class {
    func didChangeSearchText(cell: SearchBarCell, query: String)
}

final class SearchBarCell: UICollectionViewCell, UISearchBarDelegate {

    weak var delegate: SearchBarCellDelegate? = nil

    private let searchBar = UISearchBar(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
        
        NotificationCenter.default.addObserver(searchBar,
                                               selector: #selector(SearchBarCell.willHideKeyboard),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()
    }

    // MARK: Public API

    func configure(query: String, placeholder: String) {
        searchBar.text = query
        searchBar.placeholder = placeholder
    }

    // MARK: Private API
    
    @objc
    private func willHideKeyboard() {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchText(cell: self, query: searchText)
    }
}
