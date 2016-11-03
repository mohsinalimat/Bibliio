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
    public var authorLabel = UILabel()
    public var imagePickerButton = UIButton()
    public var titleTextField = TextField()
    public var authorTextField = TextField()
    public var currentPageTextField = TextField()
    public var totalPagesTextField = TextField()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        configureTitleLabel()
        configureAuthorLabel()
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
        
        addSubview(titleLabel)
        
        let top = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 14)
        let leading = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 14)
        
        addConstraints([top, leading, trailing])
    }
    
    func configureAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(authorLabel)
        
        let top = NSLayoutConstraint.init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: authorLabel, attribute: .top, multiplier: 1, constant: 8)
        let centerX = NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: authorLabel, attribute: .centerX, multiplier: 1, constant: 8)
        
        addConstraints([top, centerX])
    }
    
    func configureImagePickerButton() {
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.setImage(UIImage.init(named: "camera"), for: .normal)
        imagePickerButton.contentMode = .scaleAspectFit
        imagePickerButton.backgroundColor = UIColor.softGrey()
        addSubview(imagePickerButton)
        
        let top = NSLayoutConstraint.init(item: authorLabel, attribute: .bottom, relatedBy: .equal, toItem: imagePickerButton, attribute: .top, multiplier: 1, constant: 8)
        let centerX = NSLayoutConstraint.init(item: authorLabel, attribute: .centerX, relatedBy: .equal, toItem: imagePickerButton, attribute: .centerX, multiplier: 1, constant: 8)
        let width = NSLayoutConstraint.init(item: imagePickerButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.2, constant: 0)
        let height = NSLayoutConstraint.init(item: imagePickerButton, attribute: .height, relatedBy: .equal, toItem: imagePickerButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, centerX, width, height])
    }
    
    func configureTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.borderStyle = .none
        
        addSubview(titleTextField)
        
        let top = NSLayoutConstraint.init(item: imagePickerButton, attribute: .bottom, relatedBy: .equal, toItem: titleTextField, attribute: .top, multiplier: 1, constant: 14)
        let leading = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: titleTextField, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: titleTextField, attribute: .trailing, multiplier: 1, constant: 14)
        
        addConstraints([top, leading , trailing])
    }
    
    func configureAuthorTextField() {
        authorTextField.translatesAutoresizingMaskIntoConstraints = false
        authorTextField.borderStyle = .none
        
        addSubview(authorTextField)
        
        let top = NSLayoutConstraint.init(item: titleTextField, attribute: .bottom, relatedBy: .equal, toItem: authorTextField, attribute: .top, multiplier: 1, constant: 14)
        let leading = NSLayoutConstraint.init(item: titleTextField, attribute: .leading, relatedBy: .equal, toItem: authorTextField, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: titleTextField, attribute: .trailing, relatedBy: .equal, toItem: authorTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading , trailing])
    }
    
    func configureCurrentPageTextField() {
        currentPageTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPageTextField.borderStyle = .none
        
        addSubview(currentPageTextField)
        
        let top = NSLayoutConstraint.init(item: authorTextField, attribute: .bottom, relatedBy: .equal, toItem: currentPageTextField, attribute: .top, multiplier: 1, constant: 14)
        let leading = NSLayoutConstraint.init(item: authorTextField, attribute: .leading, relatedBy: .equal, toItem: currentPageTextField, attribute: .leading, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: currentPageTextField, attribute: .width, relatedBy: .equal, toItem: authorTextField, attribute: .trailing, multiplier: 0.4, constant: 0)
        
        addConstraints([top, leading, width])
    }
    
    func configureTotalPagesTextField() {
        totalPagesTextField.translatesAutoresizingMaskIntoConstraints = false
        totalPagesTextField.borderStyle = .none
        
        addSubview(totalPagesTextField)
        
        let top = NSLayoutConstraint.init(item: currentPageTextField, attribute: .top, relatedBy: .equal, toItem: totalPagesTextField, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: authorTextField, attribute: .trailing, relatedBy: .equal, toItem: totalPagesTextField, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: totalPagesTextField, attribute: .width, relatedBy: .equal, toItem: currentPageTextField, attribute: .width, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: totalPagesTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 14)
        
        addConstraints([top, trailing, width, bottom])
    }
    
    
}
