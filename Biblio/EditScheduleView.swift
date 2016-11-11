//
//  EditScheduleView.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class EditScheduleView: UIView {
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    var finishByCell = UITableViewCell()
    var readingGoalCell = UITableViewCell()
    var readingGoalTextField: UITextField!
    var scheduleCell = UITableViewCell()
    var reminderCell = UITableViewCell()
    var reminderLabel = UILabel()
    var reminderSwitch = UISwitch()
    var pickerView = UIDatePicker()
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.white
        configureTableView()
        configureFinishByCell()
        configureReadingGoalCell()
        configureScheduleCell()
        configureReminderCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        addSubview(tableView)
        
        let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        tableViewHeightConstraint = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, tableViewHeightConstraint, trailing, bottom])
    }
    
    private func configureFinishByCell() {
        finishByCell.accessoryType = .disclosureIndicator
        finishByCell.selectionStyle = .none
    }
    
    private func configureReadingGoalCell() {
        readingGoalTextField = UITextField(frame: readingGoalCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        readingGoalTextField.keyboardType = .numberPad
        readingGoalTextField.placeholder = "Pages"
        readingGoalCell.addSubview(readingGoalTextField)
        readingGoalCell.selectionStyle = .none
    }
    
    private func configureScheduleCell() {
        scheduleCell.accessoryType = .disclosureIndicator
        scheduleCell.selectionStyle = .none
    }
    
    private func configureReminderCell() {
        reminderCell.accessoryView = reminderSwitch
        reminderCell.textLabel?.text = "Reminders"
        reminderCell.selectionStyle = .none
    }
    
    private func configureReminderLabel() {
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.textColor = .darkText
        reminderLabel.text = "Reminders"
        reminderLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(reminderLabel)
        
        let top = NSLayoutConstraint(item: reminderLabel, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: reminderLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        
        addConstraints([top, leading])
    }
    
    private func configureReminderSwitch() {
        reminderSwitch.translatesAutoresizingMaskIntoConstraints = false
        reminderSwitch.isOn = false
        addSubview(reminderSwitch)
        
        let top = NSLayoutConstraint(item: reminderSwitch, attribute: .centerY, relatedBy: .equal, toItem: reminderLabel, attribute: .centerY, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: reminderSwitch, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        let bottom = NSLayoutConstraint(item: reminderSwitch, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)

        addConstraints([top, trailing, bottom])
    }
    
    private func configureTimePickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .time
        pickerView.tintColor = .white
        pickerView.isEnabled = false
        addSubview(pickerView)
        
        let top = NSLayoutConstraint(item: pickerView, attribute: .top, relatedBy: .equal, toItem: reminderLabel, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: pickerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: pickerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: pickerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)
        let height = NSLayoutConstraint(item: pickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        
        addConstraints([top, leading, trailing, bottom, height])
    }
}
