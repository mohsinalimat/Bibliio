//
//  ViewController.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

public class AddBookViewController: BaseInputViewController {
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    var imagePicker = UIImagePickerController()
    var didChooseImage = false
    var book: Book = Book()
    var addBookView = AddBookView()
    
    // MARK: - View Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Actions
    
    @objc private func saveButtonPressed(_ sender: Any) {
        if shouldSave() == true {
            save()
            dismiss(animated: true, completion: nil)
        } else {
            showAlert()
        }
    }
    
    @objc private func imagePickerButtonPressed(_ sender: Any) {
        let takePicture = UIAlertAction(title: Constants.ImagePicker.TakeMessage, style: .default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.openCamera()
        })
        
        let choosePicture = UIAlertAction(title: Constants.ImagePicker.ChooseMessage, style: .default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.openGallery()
        })
        
        let cancel = UIAlertAction(title: Constants.Action.Cancel, style: .cancel, handler: nil)
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(takePicture)
        actionSheet.addAction(choosePicture)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Set up
    
    private func setup() {
        configureAddBookView()
        imagePicker.delegate = self
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureAddBookView() {
        addBookView.authorTextField.delegate = self
        addBookView.titleTextField.delegate = self
        addBookView.currentPageTextField.delegate = self
        addBookView.totalPagesTextField.delegate = self
        addBookView.imagePickerButton.addTarget(self, action: #selector(imagePickerButtonPressed(_:)), for: .touchUpInside)
        
        addBookView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addBookView)
        
        let top = NSLayoutConstraint(item: addBookView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: addBookView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: addBookView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: addBookView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    // MARK: - UI
    
    func showAlert() {
        let alert = UIAlertController(title: "Oops", message: "Fill in at least the title and the number of pages!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.Action.OK, style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Save
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(book)
        }
    }
    
    func shouldSave() -> Bool {
        guard let title = addBookView.titleTextField.text
            else { return false }
        
        guard title.characters.count != 0
            else { return false }
        
        guard let totalPages = addBookView.totalPagesTextField.text
            else { return false }
        
        guard totalPages.characters.count != 0
            else { return false }
        
        guard let currentPage = addBookView.currentPageTextField.text
            else { return false }
        
        guard currentPage.characters.count != 0
            else { return false }
        
        guard let page = Int(currentPage)
            else { return false }
        
        guard let total = Int(totalPages)
            else { return false }
        
        guard total >= page
            else { return false }
        
        book = Book(title: title, currentPage: page, totalPages: total)
        
        if let author = addBookView.authorTextField.text {
            book.author = author
        }
        
        if let image = addBookView.imagePickerButton.currentImage, didChooseImage == true {
            
            if let data = UIImageJPEGRepresentation(image, 1.0) {
                book.imageData = data
            }
        }
        
        return true
    }
}

extension AddBookViewController: UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addBookView.titleTextField {
            addBookView.authorTextField.becomeFirstResponder()
        } else if textField == addBookView.authorTextField {
            addBookView.currentPageTextField.becomeFirstResponder()
        } else if textField == addBookView.currentPageTextField {
            addBookView.totalPagesTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == addBookView.currentPageTextField || textField == addBookView.totalPagesTextField {
            let numericCharacterSet = NSCharacterSet.decimalDigits.inverted
            guard string.rangeOfCharacter(from: numericCharacterSet) == nil
                else { return false }
        }
        return true
    }
}

extension AddBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no camera.", preferredStyle: .alert)
            let ok = UIAlertAction(title: Constants.Action.OK, style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addBookView.imagePickerButton.contentMode = .scaleAspectFit
        addBookView.imagePickerButton.setImage(chosenImage, for: .normal)
        didChooseImage = true
        dismiss(animated: true, completion: nil)
    }
}
