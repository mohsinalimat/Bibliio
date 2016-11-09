//
//  DateInputViewController.swift
//  Biblio
//
//  Created by Adam on 11/8/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class DatePickerViewController: BaseInputViewController {
    
    var datePicker = UIDatePicker()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.addSubview(datePicker)
        
        let top = NSLayoutConstraint(item: datePicker, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: datePicker, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
}
