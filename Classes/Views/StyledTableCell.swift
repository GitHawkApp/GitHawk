//
//  StyledTableCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class StyledTableCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setup(with file: RepositoryFile) {
        textLabel?.text = file.name
        
        let imageName = file.isDirectory ? "file-directory" : "file"
        imageView?.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = Styles.Colors.blueGray.color
        accessoryType = file.isDirectory ? .disclosureIndicator : .none
    }

    private func configure() {
        textLabel?.font = Styles.Fonts.body

        let background = UIView()
        background.backgroundColor = Styles.Colors.Gray.alphaLighter
        selectedBackgroundView = background
    }
    
}
