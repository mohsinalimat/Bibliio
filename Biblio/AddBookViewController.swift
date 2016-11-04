//
//  ViewController.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

public protocol AddBookViewControllerDelegate: class {
    
    func addBookViewController(_ vc: AddBookViewController, _ didSave: Book)
}

public class AddBookViewController: BaseInputViewController {
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    weak var delegate: AddBookViewControllerDelegate?
    
    var imagePicker = UIImagePickerController()
    
    var choseImage = false

    var book: Book = Book()
    
    var addBookView = AddBookView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    
    func saveButtonPressed(_ sender: Any) {
        if shouldSave() == true {
            save()
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: "Oops", message: "Fill in at least the title and the number of pages!", preferredStyle: .alert)
            let okButton = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func cancelButtonPressed(_ sender: Any) {
        dismissKeyboard()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerButtonPressed(_ sender: Any) {
        let takePicture = UIAlertAction.init(title: "Take Picture", style: .default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.openCamera()
        })
        
        let choosePicture = UIAlertAction.init(title: "Choose From Gallery", style: .default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.openGallery()
        })
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)

        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(takePicture)
        actionSheet.addAction(choosePicture)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }

    // MARK: - Private
    
    private func setup() {
        configureAddBookView()
        imagePicker.delegate = self
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureAddBookView() {
        addBookView.authorTextField.delegate = self
        addBookView.titleTextField.delegate = self
        addBookView.currentPageTextField.delegate = self
        addBookView.totalPagesTextField.delegate = self
        addBookView.imagePickerButton.addTarget(self, action: #selector(imagePickerButtonPressed(_:)), for: .touchUpInside)
        
        addBookView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addBookView)
        
        let top = NSLayoutConstraint.init(item: addBookView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: addBookView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: addBookView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: addBookView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    // MARK: - Helper
    
    func dismissKeyboard() {
        addBookView.titleTextField.resignFirstResponder()
        addBookView.titleTextField.resignFirstResponder()
        addBookView.currentPageTextField.resignFirstResponder()
        addBookView.totalPagesTextField.resignFirstResponder()
    }
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(book)
        }
        delegate?.addBookViewController(self, book)
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
        
        book = Book(title: title, pages: Int(totalPages)!)
        
        if let author = addBookView.authorTextField.text {
            book.author = author
        }
        
        if let image = addBookView.imagePickerButton.currentImage, choseImage == true {
  
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
        } else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no camera.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
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
        choseImage = true
        dismiss(animated: true, completion: nil)
    }
}

