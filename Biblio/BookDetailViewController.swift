//
//  BookDetailViewController.swift
//  Bibliio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

class BookDetailViewController: BaseInputViewController {
    
    var bookDetailView = BookDetailView()
    var book = Book() {
        didSet {
            tempBook = book.copy() as! Book
            updateUI()
        }
    }
    var tempBook = Book()
    let realm = try! Realm()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        saveButton.backgroundColor = UIColor.deepBlue()
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        configureBookDetailView()
    }
    
    func configureBookDetailView() {
        bookDetailView.translatesAutoresizingMaskIntoConstraints = false
        bookDetailView.tableView.dataSource = self
        bookDetailView.tableView.delegate = self
        bookDetailView.currentPageTextField.delegate = self
        contentView.addSubview(bookDetailView)
        
        let top = NSLayoutConstraint(item: bookDetailView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: bookDetailView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: bookDetailView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: bookDetailView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    // MARK: - UI
    
    func updateUI() {
        bookDetailView.titleLabel.text = tempBook.title
        bookDetailView.authorLabel.text = tempBook.author
        bookDetailView.pagesReadLabel.text = "\(tempBook.currentPage) of \(tempBook.totalPages)"
        bookDetailView.currentPageTextField.text = "\(tempBook.currentPage)"
        bookDetailView.progressView.setProgress(value: tempBook.percentCompleted, animated: true, duration: 1, completion: nil)
        
        if let finishByDate = tempBook.finishDate {
            bookDetailView.finishByCell.detailTextLabel?.text = DateFormatter.shortString(forDate: finishByDate)
        } else {
            bookDetailView.finishByCell.detailTextLabel?.text = ""
        }
        
        if let imageData = tempBook.imageData {
            bookDetailView.progressView.image = UIImage(data: imageData)
        } else {
            let letterLabel = UILabel()
            letterLabel.font = UIFont.systemFont(ofSize: 50)
            letterLabel.textColor = UIColor.gray
            let firstLetter: Character = tempBook.title.uppercased().characters.first!
            letterLabel.text = String(firstLetter)
            letterLabel.sizeToFit()
            bookDetailView.progressView.fillColor = UIColor.separator()
            bookDetailView.progressView.centralView = letterLabel
        }
    }
    
    // MARK: - Action
    
    func saveButtonPressed(_ sender: Any) {
        save()
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        try! realm.write {
            // copy book
            book.currentPage = tempBook.currentPage
            book.pagesPerDayGoal = tempBook.pagesPerDayGoal
            book.readingDays.removeAll()
            book.readingDays.append(objectsIn: tempBook.readingDays)
            book.lastRead = tempBook.lastRead
            book.remindersOn = tempBook.remindersOn
            tempBook.remindersOn = false
            realm.add(book, update: true)
        }
    }
}

extension BookDetailViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookDetailView.finishByCell
        return cell
    }
}

extension BookDetailViewController: EditScheduleDelegate {
    
    // MARK: - EditScheduleDelegate

    func editScheduleViewController(_ editScheduleViewController: EditScheduleViewController, didSaveBook: Book) {
        save()
        updateUI()
    }
}

extension BookDetailViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditScheduleViewController()
        vc.book = tempBook
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BookDetailViewController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numericCharacterSet = NSCharacterSet.decimalDigits.inverted
        guard string.rangeOfCharacter(from: numericCharacterSet) == nil
            else { return false }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.characters.count > 0
            else {
                textField.text = "\(tempBook.currentPage)"
                return
        }
        
        let input = Int(text)!
        let page = input > tempBook.totalPages ? tempBook.totalPages : input
        tempBook.currentPage = page
        updateUI()
    }
}
