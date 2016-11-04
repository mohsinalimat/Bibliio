//
//  AddBookView.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class AddBookView: UIView {
    
    public var titleLabel = UILabel()
    public var imagePickerButton = UIButton()
    public var titleTextField = TextField()
    public var authorTextField = TextField()
    public var currentPageTextField = TextField()
    public var totalPagesTextField = TextField()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        
//        translatesAutoresizingMaskIntoConstraints = false
//        let height = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
//        
//        addConstraint(height)
        configureTitleLabel()
        configureImagePickerButton()
        configureTitleTextField()
        configureAuthorTextField()
        configureCurrentPageTextField()
        configureTotalPagesTextField()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        imagePickerButton.layer.cornerRadius = imagePickerButton.frame.width / 2.0
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "What are you reading?"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightLight)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        let top = NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 14)
        let leading = NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        addConstraints([top, leading, trailing])
    }
    
    func configureImagePickerButton() {
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.setImage(UIImage.init(named: "camera"), for: .normal)
        imagePickerButton.contentMode = .scaleAspectFit
        imagePickerButton.backgroundColor = UIColor.softGrey()
        imagePickerButton.clipsToBounds = true
        addSubview(imagePickerButton)
        
        let top = NSLayoutConstraint.init(item: imagePickerButton, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 14)
        let centerX = NSLayoutConstraint.init(item: imagePickerButton, attribute: .centerX, relatedBy: .equal, toItem: titleLabel, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: imagePickerButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.25, constant: 0)
        let height = NSLayoutConstraint.init(item: imagePickerButton, attribute: .height, relatedBy: .equal, toItem: imagePickerButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, centerX, width, height])
    }
    
    func configureTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.lineColor = .darkGray
        titleTextField.lineWidth = 0.5
        titleTextField.font = UIFont.systemFont(ofSize: 20)
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .none
        
        addSubview(titleTextField)
        
        let top = NSLayoutConstraint.init(item: titleTextField, attribute: .top, relatedBy: .equal, toItem: imagePickerButton, attribute: .bottom, multiplier: 1, constant: 8)
        let leading = NSLayoutConstraint.init(item: titleTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint.init(item: titleTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        
        addConstraints([top, leading , trailing])
    }
    
    func configureAuthorTextField() {
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        authorTextField.lineColor = .darkGray
        authorTextField.lineWidth = 0.5
        authorTextField.font = UIFont.systemFont(ofSize: 20)
        authorTextField.placeholder = "Author"
        authorTextField.borderStyle = .none
        
        addSubview(authorTextField)
        
        let top = NSLayoutConstraint.init(item: authorTextField, attribute: .top, relatedBy: .equal, toItem: titleTextField, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint.init(item: authorTextField, attribute: .leading, relatedBy: .equal, toItem: titleTextField, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: authorTextField, attribute: .trailing, relatedBy: .equal, toItem: titleTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading , trailing])
    }
    
    func configureCurrentPageTextField() {
        currentPageTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPageTextField.borderStyle = .none
        currentPageTextField.lineColor = .darkGray
        currentPageTextField.font = UIFont.systemFont(ofSize: 20)
        currentPageTextField.placeholder = "Current page"
        currentPageTextField.text = "1"
        currentPageTextField.keyboardType = .numberPad
        currentPageTextField.lineWidth = 0.5
        
        addSubview(currentPageTextField)
        
        let top = NSLayoutConstraint.init(item: currentPageTextField, attribute: .top, relatedBy: .equal, toItem: authorTextField, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint.init(item: currentPageTextField, attribute: .leading, relatedBy: .equal, toItem: authorTextField, attribute: .leading, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: currentPageTextField, attribute: .width, relatedBy: .equal, toItem: authorTextField, attribute: .width, multiplier: 0.4, constant: 0)
        let bottom = NSLayoutConstraint.init(item: currentPageTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -40)

        addConstraints([top, leading, width, bottom])
    }
    
    func configureTotalPagesTextField() {
        totalPagesTextField.translatesAutoresizingMaskIntoConstraints = false
        totalPagesTextField.borderStyle = .none
        totalPagesTextField.lineColor = .darkGray
        totalPagesTextField.font = UIFont.systemFont(ofSize: 20)
        totalPagesTextField.placeholder = "Total pages"
        totalPagesTextField.keyboardType = .numberPad
        totalPagesTextField.lineWidth = 0.5
        
        addSubview(totalPagesTextField)
        
        let top = NSLayoutConstraint.init(item: totalPagesTextField, attribute: .top, relatedBy: .equal, toItem: currentPageTextField, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: totalPagesTextField, attribute: .trailing, relatedBy: .equal, toItem: authorTextField, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: totalPagesTextField, attribute: .width, relatedBy: .equal, toItem: currentPageTextField, attribute: .width, multiplier: 1, constant: 0)
    
        addConstraints([top, trailing, width])
    }
}