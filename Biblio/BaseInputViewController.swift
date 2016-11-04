//
//  BaseInputViewController.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class BaseInputViewController: UIViewController {
    
    public var outerView = UIView()
    public var containerView = UIView()
    public var scrollView = UIScrollView()
    public var contentView = UIView()
    public var cancelButton = UIButton()
    public var saveButton = UIButton()
    
    private var maskPath: UIBezierPath? = nil
    private let maskLayer = CAShapeLayer()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setup()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.layer.cornerRadius = 16
    }
    
    private func setup() {
        configureScrollView()
        configureOuterView()
        configureContainerView()
        configureContentView()
        configureCancelButton()
        configureSaveButton()
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = false
        view.addSubview(scrollView)
        
        let top = NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([top, leading, trailing, bottom])
    }
    
    func configureOuterView() {
        outerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(outerView)
        
        let top = NSLayoutConstraint.init(item: outerView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 60)
        let leading = NSLayoutConstraint.init(item: outerView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint.init(item: outerView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: -14)
        let bottom = NSLayoutConstraint.init(item: outerView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint.init(item: outerView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0)
        
        scrollView.addConstraints([top, leading, trailing, bottom, centerX])
    }
    
    func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        outerView.addSubview(containerView)
        
        let top = NSLayoutConstraint.init(item: containerView, attribute: .top, relatedBy: .equal, toItem: outerView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: containerView, attribute: .leading, relatedBy: .equal, toItem: outerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: outerView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: outerView, attribute: .bottom, multiplier: 1, constant: 0)
        
        outerView.addConstraints([top, leading, trailing, bottom])
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        
        let top = NSLayoutConstraint.init(item: contentView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: contentView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        
        containerView.addConstraints([top, leading, trailing])
    }
    
    func configureCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor.softGrey()
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        cancelButton.titleLabel?.textColor = .white
        cancelButton.setTitle("Cancel", for: .normal)
        containerView.addSubview(cancelButton)
        
        let top = NSLayoutConstraint.init(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: cancelButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.5, constant: 0)
        //let height = NSLayoutConstraint.init(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.1, constant: 0)
        
        containerView.addConstraints([top, leading, bottom, width])
    }
    
    func configureSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = UIColor.deepBlue()
        saveButton.titleLabel?.textColor = .white
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        saveButton.setTitle("Save", for: .normal)
        containerView.addSubview(saveButton)
        
        let leading = NSLayoutConstraint.init(item: saveButton, attribute: .leading, relatedBy: .equal, toItem: cancelButton, attribute: .trailing, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: saveButton, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint.init(item: saveButton, attribute: .top, relatedBy: .equal, toItem: cancelButton, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: saveButton, attribute: .width, relatedBy: .equal, toItem: cancelButton, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint.init(item: saveButton, attribute: .height, relatedBy: .equal, toItem: cancelButton, attribute: .height, multiplier: 1, constant: 0)
        
        containerView.addConstraints([leading, top, trailing, width, height])
    }
}