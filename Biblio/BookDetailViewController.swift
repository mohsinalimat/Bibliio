//
//  BookDetailViewController.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class BookDetailViewController: BaseInputViewController {

    var bookDetailView = BookDetailView()
    var book = Book() {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bookDetailView.progressView.setProgress(value: book.progress.percentage, animated: true, duration: 1.0, completion: nil)
    }
    
    func setup() {
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(UIColor.deepBlue(), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        configureBookDetailView()
    }
    
    func configureBookDetailView() {
        bookDetailView.translatesAutoresizingMaskIntoConstraints = false
        bookDetailView.tableView.dataSource = self
        bookDetailView.tableView.delegate = self
        contentView.addSubview(bookDetailView)
        
        let top = NSLayoutConstraint(item: bookDetailView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: bookDetailView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: bookDetailView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: bookDetailView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    func updateUI() {
        bookDetailView.titleLabel.text = book.title
        bookDetailView.authorLabel.text = book.author
        bookDetailView.pagesReadLabel.text = "\(book.progress.currentPage) of \(book.progress.totalPages)"
        bookDetailView.currentPageTextField.text = "\(book.progress.currentPage)"
    }
    
    // MARK: - Action
    
    func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveButtonPressed(_ sender: Any) {
    }
}

extension BookDetailViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "TableViewCell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.textColor = .darkText
        cell.textLabel?.text = "You'll finish by"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: book.progress.finishDate)
        cell.detailTextLabel?.textColor = .darkText

        return cell
    }
}

extension BookDetailViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditScheduleViewController()
        vc.book = book
        navigationController?.pushViewController(vc, animated: true)
    }
}
