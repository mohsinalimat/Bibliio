//
//  BookListCollectionViewCell.swift
//  Biblio
//
//  Created by Adam on 10/31/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

protocol BookListCellDelegate: NSObjectProtocol {
    
    func moreButtonPressed(cell: BookListCollectionViewCell) -> ()
}

class BookListCollectionViewCell: UICollectionViewCell {

    weak open var delegate: BookListCellDelegate?
    
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagesReadLabel: UILabel!
    @IBOutlet weak var lastReadLabel: UILabel!
    @IBOutlet weak var finishByLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    private let shadowLayer = CALayer()
    private let letterLabel = UILabel()
    weak var book: Book? {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - IBAction
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        
        self.delegate?.moreButtonPressed(cell: self)
    }
    
    // MARK: - UI
    
    func updateAppearance() {
        titleLabel.text = book?.title
        
        if let _ = book?.image {
            
        } else {
            letterLabel.font = UIFont.systemFont(ofSize: 50)
            letterLabel.textColor = UIColor.gray
            let firstLetter: Character = book!.title.characters.first!
            letterLabel.text = String(firstLetter)
            letterLabel.sizeToFit()
            progressView.fillColor = UIColor.separator()
            progressView.centralView = letterLabel
        }
    }

}
