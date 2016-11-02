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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var authorTextField: TextField!
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var totalPagesTextField: TextField!
    @IBOutlet weak var currentPageTextField: TextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var imageViewTapGesture: UITapGestureRecognizer!
    var book = Book()

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorTextField.delegate = self
        titleTextField.delegate = self
        currentPageTextField.delegate = self
        totalPagesTextField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.layer.bounds.width / 2.0
    }
    
    // MARK: - IBAction
    
    @IBAction func imageViewTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if shouldSave() == true {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - UITextFieldDelegate
    
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

    // MARK: - Helper
    
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
}

