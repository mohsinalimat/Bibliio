//
//  BookTableViewCell.swift
//  Biblio
//
//  Created by Adam on 10/28/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    weak open var book: Book? {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateAppearance() {
        
    }
}
