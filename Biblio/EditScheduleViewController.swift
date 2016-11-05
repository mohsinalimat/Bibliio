//
//  EditScheduleViewController.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class EditScheduleViewController: BaseInputViewController {
    
    private var editScheduleView = EditScheduleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        cancelButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        configureEditScheduleView()
    }
    
    func saveButtonPressed(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func configureEditScheduleView() {
        editScheduleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editScheduleView)
        
        let top = NSLayoutConstraint(item: editScheduleView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: editScheduleView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: editScheduleView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: editScheduleView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
}
