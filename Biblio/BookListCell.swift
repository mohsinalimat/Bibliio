//
//  BookListCollectionViewCell.swift
//  Biblio
//
//  Created by Adam on 10/31/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

protocol BookListCellDelegate: NSObjectProtocol {
    
    func moreButtonPressed(cell: BookListCell) -> ()
}

class BookListCell: UICollectionViewCell {
    
    static let Identifier = "BookListCell"
    
    weak open var delegate: BookListCellDelegate?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagesReadLabel: UILabel!
    @IBOutlet weak var lastReadLabel: UILabel!
    @IBOutlet weak var finishByLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var couldFinishLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var lastReadTitleLabel: UILabel!
    var maskPath: UIBezierPath? = nil
    let maskLayer = CAShapeLayer()
    
    private let letterLabel = UILabel()
    
    weak var book: Book? {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
   
        containerView.layer.cornerRadius = 17
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maskPath = UIBezierPath.init(roundedRect: topView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 16, height: 16))
        maskLayer.path = maskPath!.cgPath;
        topView.layer.mask = maskLayer;
    }
    
    func setup() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 1
        readLabel.font = UIFont.titleLabelFont()
        pagesReadLabel.font = UIFont.valueLabelFont()
        lastReadTitleLabel.font = UIFont.titleLabelFont()
        lastReadLabel.font = UIFont.valueLabelFont()
        couldFinishLabel.font = UIFont.titleLabelFont()
        finishByLabel.font = UIFont.valueLabelFont()
    }
    
    //MARK: - IBAction
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        self.delegate?.moreButtonPressed(cell: self)
    }
    
    // MARK: - UI
    
    func updateAppearance() {
        guard let book = self.book
            else { return }
        
        titleLabel.text = book.title
        pagesReadLabel.text = "\(book.progress.currentPage) of \(book.totalPages)"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        lastReadLabel.text = "\(formatter.string(from: book.progress.lastRead))"
        finishByLabel.text = "\(formatter.string(from: book.progress.finishDate))"
        
        if let imageData = book.imageData {
            let image = UIImage(data: imageData)
            let imageView = UIImageView(image: image)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            progressView.centralView = imageView
        } else {
            letterLabel.font = UIFont.systemFont(ofSize: 50)
            letterLabel.textColor = UIColor.gray
            let firstLetter: Character = book.title.uppercased().characters.first!
            letterLabel.text = String(firstLetter)
            letterLabel.sizeToFit()
            progressView.fillColor = UIColor.separator()
            progressView.centralView = letterLabel
        }
    }
    
    func animateProgress() {
        guard let book = book
            else { return }
        progressView.setProgress(value: book.progress.percentage, animated: true, duration: 0.5, completion: nil)
    }
}
