//
//  ViewController.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var authorTextField: TextField!
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var totalPagesTextField: TextField!
    @IBOutlet weak var currentPageTextField: TextField!
    var tapGesture = UITapGestureRecognizer()
    var book = Book()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == titleTextField {
            authorTextField.becomeFirstResponder()
        } else if textField == authorTextField {
            currentPageTextField.becomeFirstResponder()
        } else if textField == currentPageTextField {
            totalPagesTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }

    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(book)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if shouldSave() == true {
            save()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func shouldSave() -> Bool {
        
        guard let title = titleTextField.text
            else { return false }
        
        guard let _ = currentPageTextField.text
            else { return false }
        
        guard let totalPages = totalPagesTextField.text
            else { return false }
        
        book = Book(title: title, pages: Int(totalPages)!)
        
        if let author = authorTextField.text {
            book.author = author
        }
        
        return true
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func imageViewTapped(_ sender: UITapGestureRecognizer) {
        
    }
}

