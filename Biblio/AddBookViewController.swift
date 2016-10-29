//
//  ViewController.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var authorTextField: TextField!
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var totalPagesTextField: TextField!
    @IBOutlet weak var currentPageTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        save()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

