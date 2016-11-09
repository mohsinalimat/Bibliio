//
//  DateInputViewController.swift
//  Biblio
//
//  Created by Adam on 11/8/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: NSObjectProtocol {
    
    func datePickerViewController(_ dayPickerViewController: DatePickerViewController, selectedDate: Date)
}

class DatePickerViewController: BaseInputViewController {
    
    weak var delegate: DatePickerDelegate?
    
    var datePicker = UIDatePicker()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Target Action
    
    dynamic private func saveButtonPressed(_ sender: Any) {
        let date = datePicker.date
        delegate?.datePickerViewController(self, selectedDate: date)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        contentView.backgroundColor = .white
        contentView.addSubview(datePicker)
        
        let top = NSLayoutConstraint(item: datePicker, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: datePicker, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
}
