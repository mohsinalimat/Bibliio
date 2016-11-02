//
//  ViewController.swift
//  Biblio
//
//  Created by Adam on 10/25/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

class AddBookViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var imagePicker = UIImagePickerController()
    
    var choseImage = false

    var book: Book = Book()
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var authorTextField: TextField!
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var totalPagesTextField: TextField!
    @IBOutlet weak var currentPageTextField: TextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerButton.clipsToBounds = true
        imagePicker.delegate = self
        scrollView.delaysContentTouches = false
        authorTextField.delegate = self
        titleTextField.delegate = self
        currentPageTextField.delegate = self
        totalPagesTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imagePickerButton.layer.cornerRadius = imagePickerButton.layer.bounds.width / 2.0
    }
    
    // MARK: - IBAction
    
    @IBAction func saveButtonPressed(_ sender: Any) {
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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickerButtonPressed(_ sender: Any) {
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

    // MARK: - Helper
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(book)
        }
    }
    
    func shouldSave() -> Bool {
        guard let title = titleTextField.text
            else { return false }
        
        guard title.characters.count != 0
            else { return false }
        
        guard let totalPages = totalPagesTextField.text
            else { return false }
        
        guard totalPages.characters.count != 0
            else { return false }
        
        book = Book(title: title, pages: Int(totalPages)!)
        
        if let author = authorTextField.text {
            book.author = author
        }
        
        if let image = imagePickerButton.currentImage, choseImage == true {
  
            if let data = UIImageJPEGRepresentation(image, 1.0) {
                book.imageData = data
            }
        }
        
        return true
    }
}

extension AddBookViewController: UITextFieldDelegate {
    
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePickerButton.contentMode = .scaleAspectFit
        imagePickerButton.setImage(chosenImage, for: .normal)
        choseImage = true
        dismiss(animated: true, completion: nil)
    }
}

