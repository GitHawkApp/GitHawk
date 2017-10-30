//
//  RepositoryCodeDirectoryCellExtension.swift
//  Freetime
//
//  Created by Nicholas Meschke on 10/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

extension StyledTableCell {
    
    func setup(with file: RepositoryFile) {
        textLabel?.text = file.name
        
        isAccessibilityElement = true
        accessibilityTraits |= UIAccessibilityTraitButton
        let fileType = file.isDirectory
            ? NSLocalizedString("Directory", comment: "Used to specify the code cell is a directory.")
            : NSLocalizedString("File", comment: "Used to specify the code cell is a file.")
        accessibilityLabel = contentView.subviews
            .flatMap { $0.accessibilityLabel }
            .reduce("") { "\($0).\n\($1)" }
            .appending(".\n\(fileType)")
        accessibilityHint = file.isDirectory
            ? NSLocalizedString("Shows the contents of the directory", comment: "")
            : NSLocalizedString("Shows the contents of the file", comment: "")
        
        let imageName = file.isDirectory ? "file-directory" : "file"
        imageView?.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = Styles.Colors.blueGray.color
        accessoryType = file.isDirectory ? .disclosureIndicator : .none
    }
    
}
