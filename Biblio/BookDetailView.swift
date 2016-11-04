//
//  BookDetailView.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class BookDetailView: UIView {

    public var titleLabel = UILabel()
    public var authorLabel = UILabel()
    public var progressView = CircularProgressView()
    public var pagesReadLabel = UILabel()
    public var currentPageLabel = UILabel()
    public var currentPageTextField = UITextField()
    public var separator = SeparatorView()
    public var tableView = UITableView()
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.deepBlue()
        configureTitleLabel()
        configureAuthorLabel()
        configureProgressView()
        configurePagesReadLabel()
        configureCurrentPageLabel()
        configureCurrentPageTextField()
        configureSeparator()
        configureTableView()
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        let top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        let trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)

        addConstraints([top, leading, trailing])
    }
    
    func configureAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textAlignment = .center
        authorLabel.text = "Author"
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        authorLabel.textColor = .white
        addSubview(authorLabel)
        
        let top = NSLayoutConstraint(item: authorLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)
        let centerX = NSLayoutConstraint(item: authorLabel, attribute: .centerX, relatedBy: .equal, toItem: titleLabel, attribute: .centerX, multiplier: 1, constant: 0)
        
        addConstraints([top, centerX])
    }
    
    func configureProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.borderWidth = 8
        progressView.progressWidth = 8
        progressView.borderColor = UIColor.lightGreen()
        progressView.progressColor = UIColor.jade()
        progressView.progress = 0.5
        addSubview(progressView)
        
        let top = NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: .equal, toItem: authorLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let centerX = NSLayoutConstraint(item: progressView, attribute: .centerX, relatedBy: .equal, toItem: authorLabel, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: progressView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.25, constant: 0)
        let height = NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: progressView, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, centerX, width, height])
    }
    
    func configurePagesReadLabel() {
        pagesReadLabel.translatesAutoresizingMaskIntoConstraints = false
        pagesReadLabel.font = UIFont.systemFont(ofSize: 20)
        pagesReadLabel.text = "132 of 200"
        pagesReadLabel.textColor = .white
        addSubview(pagesReadLabel)
        
        let top = NSLayoutConstraint(item: pagesReadLabel, attribute: .top, relatedBy: .equal, toItem: progressView, attribute: .bottom, multiplier: 1, constant: 20)
        let centerX = NSLayoutConstraint(item: pagesReadLabel, attribute: .centerX, relatedBy: .equal, toItem: progressView, attribute: .centerX, multiplier: 1, constant: 0)
       // let trailing = NSLayoutConstraint(item: pagesReadLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        
        addConstraints([top, centerX])
    }
    
    func configureCurrentPageLabel() {
        currentPageLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPageLabel.font = UIFont.systemFont(ofSize: 20)
        currentPageLabel.text = "I'm on page"
        currentPageLabel.textColor = .white
        addSubview(currentPageLabel)

        let top = NSLayoutConstraint(item: currentPageLabel, attribute: .top, relatedBy: .equal, toItem: pagesReadLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: currentPageLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        
        addConstraints([top, leading])
    }
    
    func configureCurrentPageTextField() {
        currentPageTextField.translatesAutoresizingMaskIntoConstraints = false
        currentPageTextField.font = UIFont.systemFont(ofSize: 20)
        currentPageTextField.placeholder = "Page"
        currentPageTextField.textColor = .white
        currentPageTextField.tintColor = .white
        addSubview(currentPageTextField)
        
        let top = NSLayoutConstraint(item: currentPageTextField, attribute: .top, relatedBy: .equal, toItem: currentPageLabel, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: currentPageTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        
        addConstraints([top, trailing])
    }
    
    func configureSeparator() {
        addSubview(separator)
        
        let top = NSLayoutConstraint(item: separator, attribute: .top, relatedBy: .equal, toItem: currentPageLabel, attribute: .bottom, multiplier: 1, constant: 6)
        let leading = NSLayoutConstraint(item: separator, attribute: .leading, relatedBy: .equal, toItem: currentPageLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: separator, attribute: .trailing, relatedBy: .equal, toItem: currentPageTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, trailing])
    }
    
    func configureTableView () {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        addSubview(tableView)

        let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: separator, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)
        let height = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        addConstraints([top, leading, trailing, bottom, height])
    }
}
