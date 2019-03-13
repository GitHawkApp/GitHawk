//
//  SearchSegementBarCell.swift
//  Freetime
//
//  Created by Ehud Adler on 3/12/19.
//  Copyright © 2019 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SearchSegmentBarCell: UICollectionViewCell, SearchableCell, UISearchBarDelegate {

    weak var delegate: SearchBarCellDelegate?

    private let searchBar = UISearchBar(frame: .zero)
    private let segmentControl = UISegmentedControl(frame: .zero)
    var segmentControlLeadingConstraint: Constraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self

        contentView.addSubview(searchBar)
        contentView.addSubview(segmentControl)

        searchBar.snp.makeConstraints { make in
            make.leading.centerY.equalTo(contentView)
            make.trailing.equalTo(segmentControl.snp.leading)
        }

        segmentControl.snp.makeConstraints { make in
            segmentControlLeadingConstraint = make.leading.equalTo(contentView.snp.trailing).constraint
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.top.bottom.equalTo(contentView)

        }

        segmentControl.addTarget(self, action: #selector(updateSegement), for: .valueChanged)

        setSegmentControl()
        segmentControlLeadingConstraint.deactivate()
        searchBar.resignWhenKeyboardHides()
        segmentControl.removeBorders()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentView()
    }

    // MARK: Public API

    func set(items: [String], selectedIndex: Int = 0) {
        for title in items {
            segmentControl.insertSegment(
                withTitle: title,
                at: segmentControl.numberOfSegments,
                animated: true
            )
        }
        segmentControl.selectedSegmentIndex = selectedIndex
    }

    func configure(query: String, placeholder: String) {
        searchBar.text = query
        searchBar.placeholder = placeholder
    }

    // MARK: Private API

    func setSegmentControl() {

        segmentControl.backgroundColor = .clear
        segmentControl.tintColor = .clear

        let normalFont: [AnyHashable: Any] = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)
        ]
        let selectedFont: [AnyHashable: Any] = [
            NSAttributedStringKey.foregroundColor: Styles.Colors.Blue.medium.color,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)
        ]
        segmentControl.setTitleTextAttributes(normalFont, for: .normal)
        segmentControl.setTitleTextAttributes(selectedFont, for: .selected)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didChangeSearchText(cell: self, query: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.segmentControlLeadingConstraint.deactivate()
            self.segmentControl.alpha = 1
            self.layoutIfNeeded()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.segmentControlLeadingConstraint.activate()
            self.segmentControl.alpha = 0
            self.layoutIfNeeded()
        }

    }

    @objc func updateSegement() {
        delegate?.didChangeSegment(cell: self, index: self.segmentControl.selectedSegmentIndex)
    }
}
