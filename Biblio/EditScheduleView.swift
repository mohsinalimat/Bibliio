//
//  EditScheduleView.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class EditScheduleView: UIView {
    
    public var finishByLabel = UILabel()
    public var finishDateButton = UIButton()
    public var firstSeparator = SeparatorView()
    public var readingLabel = UILabel()
    public var pageTextField = UITextField()
    public var secondSeparator = SeparatorView()
    public var repeatLabel = UILabel()
    public var daysLabel = UILabel()
    public var thirdSeparatorView = SeparatorView()
    public var tempView = DayButtonContainerView()
    public var reminderLabel = UILabel()
    public var reminderSwitch = UISwitch()
    public var pickerView = UIDatePicker()
    
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
        
        configureFinishByLabel()
        configureFinishDateButton()
        configureFirstSeparator()
        configureReadingLabel()
        configurePageTextField()
        configureSecondSeparator()
        configureRepeatLabel()
        configureDaysLabel()
        configureThirdSeparator()
        configureReminderLabel()
        configureReminderSwitch()
        configureTimePickerView()
    }
    
    private func configureFinishByLabel() {
        finishByLabel.translatesAutoresizingMaskIntoConstraints = false
        finishByLabel.font = UIFont.systemFont(ofSize: 20)
        finishByLabel.text = "I want to finish by"
        finishByLabel.textAlignment = .center
        finishByLabel.textColor = .darkText
        addSubview(finishByLabel)
        
        let top = NSLayoutConstraint(item: finishByLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 50)
        let leading = NSLayoutConstraint(item: finishByLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 14)
        
        addConstraints([top, leading])
    }
    
    private func configureFinishDateButton() {
        finishDateButton.translatesAutoresizingMaskIntoConstraints = false
        finishDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        finishDateButton.setTitleColor(.darkText, for: .normal)
        finishDateButton.setTitleColor(.darkText, for: .normal)
        addSubview(finishDateButton)
        
        let baseline = NSLayoutConstraint(item: finishDateButton, attribute: .lastBaseline, relatedBy: .equal, toItem: finishByLabel, attribute: .lastBaseline, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: finishDateButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -14)
        
        addConstraints([baseline, trailing])
    }
    
    private func configureFirstSeparator() {
        addSubview(firstSeparator)
        
        let top = NSLayoutConstraint(item: firstSeparator, attribute: .top, relatedBy: .equal, toItem: finishByLabel, attribute: .bottom, multiplier: 1, constant: 6)
        let leading = NSLayoutConstraint(item: firstSeparator, attribute: .leading, relatedBy: .equal, toItem: finishByLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: firstSeparator, attribute: .trailing, relatedBy: .equal, toItem: finishDateButton, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, trailing])
    }
    
    private func configureReadingLabel() {
        readingLabel.translatesAutoresizingMaskIntoConstraints = false
        readingLabel.textColor = .darkText
        readingLabel.text = "Reading"
        readingLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(readingLabel)
        
        let top = NSLayoutConstraint(item: readingLabel, attribute: .top, relatedBy: .equal, toItem: firstSeparator, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: readingLabel, attribute: .leading, relatedBy: .equal, toItem: finishByLabel, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([top, leading])
    }
    
    private func configurePageTextField() {
        pageTextField.translatesAutoresizingMaskIntoConstraints = false
        pageTextField.textColor = .darkText
        pageTextField.font = UIFont.systemFont(ofSize: 20)
        pageTextField.tintColor = .white
        pageTextField.textAlignment = .right
        pageTextField.keyboardType = .numberPad
        addSubview(pageTextField)
        
        let top = NSLayoutConstraint(item: pageTextField, attribute: .top, relatedBy: .equal, toItem: readingLabel, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: pageTextField, attribute: .trailing, relatedBy: .equal, toItem: firstSeparator, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: pageTextField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.25, constant: 0)
        
        addConstraints([top, trailing, width])
    }
    
    private func configureSecondSeparator() {
        addSubview(secondSeparator)
        
        let top = NSLayoutConstraint(item: secondSeparator, attribute: .top, relatedBy: .equal, toItem: readingLabel, attribute: .bottom, multiplier: 1, constant: 6)
        let leading = NSLayoutConstraint(item: secondSeparator, attribute: .leading, relatedBy: .equal, toItem: readingLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: secondSeparator, attribute: .trailing, relatedBy: .equal, toItem: pageTextField, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, trailing])
    }
    
    private func configureRepeatLabel() {
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.textColor = .darkText
        repeatLabel.text = "Every"
        repeatLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(repeatLabel)
        
        let top = NSLayoutConstraint(item: repeatLabel, attribute: .top, relatedBy: .equal, toItem: secondSeparator, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: repeatLabel, attribute: .leading, relatedBy: .equal, toItem: readingLabel, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([top, leading])
    }
    
    private func configureDaysLabel() {
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.textColor = .darkText
        daysLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(daysLabel)
        
        let top = NSLayoutConstraint(item: daysLabel, attribute: .top, relatedBy: .equal, toItem: repeatLabel, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: daysLabel, attribute: .trailing, relatedBy: .equal, toItem: secondSeparator, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, trailing])
    }
    
    private func configureThirdSeparator() {
        addSubview(thirdSeparatorView)
        
        let top = NSLayoutConstraint(item: thirdSeparatorView, attribute: .top, relatedBy: .equal, toItem: repeatLabel, attribute: .bottom, multiplier: 1, constant: 6)
        let leading = NSLayoutConstraint(item: thirdSeparatorView, attribute: .leading, relatedBy: .equal, toItem: repeatLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: thirdSeparatorView, attribute: .trailing, relatedBy: .equal, toItem: daysLabel, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, trailing])
    }
    
    
    private func configureReminderLabel() {
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.textColor = .darkText
        reminderLabel.text = "Reminders"
        reminderLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(reminderLabel)
        
        let top = NSLayoutConstraint(item: reminderLabel, attribute: .top, relatedBy: .equal, toItem: thirdSeparatorView, attribute: .bottom, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: reminderLabel, attribute: .leading, relatedBy: .equal, toItem: thirdSeparatorView, attribute: .leading, multiplier: 1, constant: 0)
        
        addConstraints([top, leading])
    }
    
    private func configureReminderSwitch() {
        reminderSwitch.translatesAutoresizingMaskIntoConstraints = false
        reminderSwitch.isOn = false
        addSubview(reminderSwitch)
        
        let top = NSLayoutConstraint(item: reminderSwitch, attribute: .centerY, relatedBy: .equal, toItem: reminderLabel, attribute: .centerY, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: reminderSwitch, attribute: .trailing, relatedBy: .equal, toItem: thirdSeparatorView, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top, trailing])
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
