//
//  EditScheduleViewController.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class EditScheduleViewController: BaseInputViewController {
    
    var editScheduleView = EditScheduleView()
    
    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        configureEditScheduleView()
    }
    
    func configureEditScheduleView() {
        editScheduleView.translatesAutoresizingMaskIntoConstraints = false
        editScheduleView.tableView.dataSource = self
        editScheduleView.tableView.delegate = self
        editScheduleView.readingGoalTextField.delegate = self
        contentView.addSubview(editScheduleView)
        
        let top = NSLayoutConstraint(item: editScheduleView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: editScheduleView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: editScheduleView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: editScheduleView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
}

extension EditScheduleViewController: DatePickerDelegate {
    
    func datePickerViewController(_ dayPickerViewController: DatePickerViewController, selectedDate: Date) {
        editScheduleView.finishByCell.textLabel?.text = DateFormatter.shortString(forDate: selectedDate)
    }
}

extension EditScheduleViewController: DayPickerDelegate {
    
    func dayPickerViewController(_ dayPickerViewController: DayPickerViewController, selectedDays: [Bool]) {
        print("Chose days")
    }
}

extension EditScheduleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = editScheduleView.finishByCell
        } else if indexPath.section == 1 {
            cell = editScheduleView.readingGoalCell
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell = editScheduleView.scheduleCell
            } else {
                cell = editScheduleView.reminderCell
            }
        } else {
            cell = UITableViewCell()
        }
        
        return cell
    }
}

extension EditScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = DatePickerViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 0 {
            let vc = DayPickerViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "I want to finish by"
        case 1:
            return "Reading"
        case 2:
            return "Every"
        default:
            return nil
        }
    }
}

extension EditScheduleViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let numericCharacterSet = NSCharacterSet.decimalDigits.inverted
        guard string.rangeOfCharacter(from: numericCharacterSet) == nil
            else { return false }
    
        return true
    }
}
