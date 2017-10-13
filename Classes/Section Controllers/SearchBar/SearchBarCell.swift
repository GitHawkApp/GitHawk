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
    var placeholder: String? {
        didSet {
            searchBar.placeholder = placeholder
        }
    }

    private let searchBar = UISearchBar(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white

        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.tintColor = Styles.Colors.Blue.medium.color
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private API

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchText(cell: self, query: searchText)
    }
}
