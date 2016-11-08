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
    
    // MARK: - Setup
    
    private func setup() {
        configureScrollView()
        configureOuterView()
        configureContainerView()
        configureContentView()
        configureCancelButton()
        configureSaveButton()
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = false
        view.addSubview(scrollView)
        
        let top = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([top, leading, trailing, bottom])
    }
    
    private func configureOuterView() {
        outerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(outerView)
        
        let top = NSLayoutConstraint(item: outerView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 60)
        let leading = NSLayoutConstraint(item: outerView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint(item: outerView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: -14)
        let bottom = NSLayoutConstraint(item: outerView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: outerView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0)
        
        scrollView.addConstraints([top, leading, trailing, bottom, centerX])
    }
    
    private func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        outerView.addSubview(containerView)
        
        let top = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: outerView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: outerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: outerView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: outerView, attribute: .bottom, multiplier: 1, constant: 0)
        
        outerView.addConstraints([top, leading, trailing, bottom])
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        
        let top = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        
        containerView.addConstraints([top, leading, trailing])
    }
    
    private func configureCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor.softGrey()
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        cancelButton.titleLabel?.textColor = .white
        cancelButton.setTitle("Cancel", for: .normal)
        containerView.addSubview(cancelButton)
        
        let top = NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: cancelButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.5, constant: 0)
        let height = NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.13, constant: 0)

        containerView.addConstraints([top, leading, bottom, width, height])
    }
    
    private func configureSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = UIColor.deepBlue()
        saveButton.titleLabel?.textColor = .white
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        saveButton.setTitle("Save", for: .normal)
        containerView.addSubview(saveButton)
        
        let leading = NSLayoutConstraint(item: saveButton, attribute: .leading, relatedBy: .equal, toItem: cancelButton, attribute: .trailing, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: saveButton, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: saveButton, attribute: .top, relatedBy: .equal, toItem: cancelButton, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: cancelButton, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: cancelButton, attribute: .height, multiplier: 1, constant: 0)
        
        containerView.addConstraints([leading, top, trailing, width, height])
    }
}
