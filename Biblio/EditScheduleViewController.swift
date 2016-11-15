//
//  EditScheduleViewController.swift
//  Bibliio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

protocol EditScheduleDelegate: NSObjectProtocol {
    
    func editScheduleViewController(_ editScheduleViewController: EditScheduleViewController, didSaveBook: Book)
}

class EditScheduleViewController: BaseInputViewController {
    
    weak var delegate: EditScheduleDelegate?

    var editScheduleView = EditScheduleView()
    
    var book = Book() {
        didSet {
            updateUI()
        }
    }
    
    let realm = try! Realm()
    
    
    // MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        configureEditScheduleView()
    }
    
    // MARK: Target Action
    
    func saveButtonPressed(_ sender: Any) {
        self.delegate?.editScheduleViewController(self, didSaveBook: book)
        let _ = navigationController?.popViewController(animated: true)
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
    
    func updateUI() {
        if let finishByDate = book.finishDate {
            editScheduleView.finishByCell.textLabel?.text = DateFormatter.shortString(forDate: finishByDate)
        }
        editScheduleView.readingGoalTextField.text = "\(book.pagesPerDayGoal)"
        editScheduleView.scheduleCell.textLabel?.text = string(forDays: book.readingDays)
        editScheduleView.reminderSwitch.isOn = book.remindersOn
        editScheduleView.reminderSwitch.addTarget(self, action: #selector(reminderSwitchValueChanged(_:)), for: .valueChanged)
    }
    
    func reminderSwitchValueChanged(_ sender: Any) {        
        book.remindersOn = editScheduleView.reminderSwitch.isOn
    }
    
    func string(forDays days: List<BoolObject>) -> String {
        
        let boolDays: [Bool] = days.map({ $0.value })
        if boolDays.reduce(true, {$0 && $1}) {
            return "Everyday"
        }
        
        if boolDays[1..<6].reduce(false, {!$0 && !$1}) && boolDays[0] && boolDays[6] {
            return "Weekend"
        }
        
        if boolDays[1..<6].reduce(true, {$0 && $1}) && !boolDays[0] && !boolDays[6] {
            return "Weekdays"
        }
        
        let daysString =  String(boolDays.enumerated().map { (index, element) in
            return element ? "\(Date.nameOfDay(forIndex:index)), " : ""
        }.joined().characters.dropLast(2))
        
        return daysString
    }
    
}

extension EditScheduleViewController: DatePickerDelegate {
    
    func datePickerViewController(_ dayPickerViewController: DatePickerViewController, selectedDate: Date) {
        book.configureSchedule(for: selectedDate)
        updateUI()
    }
    
}

extension EditScheduleViewController: DayPickerDelegate {
    
    func dayPickerViewController(_ dayPickerViewController: DayPickerViewController, selectedDays: List<BoolObject>? ) {
        guard let days = selectedDays
            else { return }
        book.readingDays.removeAll()
        book.readingDays.append(objectsIn: days)
        updateUI()
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

extension EditScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = DatePickerViewController()
            vc.delegate = self
            vc.book = book
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 0 {
            let vc = DayPickerViewController()
            vc.book = book
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text, text.characters.count > 0
        else {
            textField.text = "\(book.pagesPerDayGoal)"
            return
        }
        
        var input = Int(text)!
        input = input > book.totalPages ? book.totalPages : input
        input = input < 0 ? 1 : input
        book.pagesPerDayGoal = input
        updateUI()
    }
    
}
