//
//  BookListCollectionViewCell.swift
//  Bibliio
//
//  Created by Adam on 10/31/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookListCell: UICollectionViewCell {
    
    static let Identifier = "BookListCell"
    
    weak open var delegate: UIViewController?
    
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
    
    let disposeBag = DisposeBag()
    
    private let letterLabel = UILabel()
    
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
    
    func configure(for viewModel: BookViewModel) {
        titleLabel.text = viewModel.title
        pagesReadLabel.text = viewModel.currentPage
        lastReadLabel.text = viewModel.lastRead
        finishByLabel.text = viewModel.finishBy
        moreButton.rx.tap.subscribe(onNext: { [unowned self] in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: Constants.Action.Cancel, style: .cancel) { [unowned self] (action) in
                 self.delegate?.dismiss(animated: true, completion: nil)
            }
            let destroyAction = UIAlertAction(title: Constants.Action.Delete, style: .destructive) { (action) in
                viewModel.delete() // not proper MVVM. View should not know what ViewModel does
            }
            alertController.addAction(cancelAction)
            alertController.addAction(destroyAction)
            self.delegate?.present(alertController, animated: true)
        }).addDisposableTo(disposeBag)
    }
    
    func setup() {
        layer.shadowColor = UIColor.black.cgColor
        readLabel.font = UIFont.titleLabelFont()
        pagesReadLabel.font = UIFont.valueLabelFont()
        lastReadTitleLabel.font = UIFont.titleLabelFont()
        lastReadLabel.font = UIFont.valueLabelFont()
        couldFinishLabel.font = UIFont.titleLabelFont()
        finishByLabel.font = UIFont.valueLabelFont()
    }
    
    // MARK: - UI
    
    func animateProgress() {
        DispatchQueue.main.async {
            //How should this work? 
            //self.progressView.setProgress(value: book.percentCompleted, animated: true, duration: 1, completion: nil)
        }
    }
}
