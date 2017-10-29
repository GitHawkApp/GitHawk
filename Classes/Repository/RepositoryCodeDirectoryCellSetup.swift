//
//  RepositoryCodeDirectoryCellSetup.swift
//  Freetime
//
//  Created by Nicholas Meschke on 10/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

extension StyledTableCell {
    
    func setup(with file: RepositoryFile) {
        textLabel?.text = file.name
        
        let imageName = file.isDirectory ? "file-directory" : "file"
        imageView?.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = Styles.Colors.blueGray.color
        accessoryType = file.isDirectory ? .disclosureIndicator : .none
    }
    
}
