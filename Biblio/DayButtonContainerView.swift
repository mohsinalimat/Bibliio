//
//  DayButtonContainerView.swift
//  Biblio
//
//  Created by Adam on 11/5/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

public class DayButtonContainerView: UIView {
 
    public var sundayButton = DayButton()
    public var mondayButton = DayButton()
    public var tuesdayButton = DayButton()
    public var wednesdayButton = DayButton()
    public var thursdayButton = DayButton()
    public var fridayButton = DayButton()
    public var saturdayButton = DayButton()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 22
    }
    
    func setup() {
        clipsToBounds = true
        configureSundayButton()
        configureMondayButton()
        configureTuesdayButton()
        configureWednesdayButton()
        configureThursdayButton()
        configureFridayButton()
        configureSaturdayButton()
    }

    func configureSundayButton() {
        sundayButton.translatesAutoresizingMaskIntoConstraints = false
        sundayButton.backgroundColor = UIColor.deepBlue()
        sundayButton.setTitle("Su", for: .normal)
        addSubview(sundayButton)
        
        let top = NSLayoutConstraint(item: sundayButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: sundayButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: sundayButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: sundayButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: (1/7), constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }
    
    func configureMondayButton() {
        mondayButton.translatesAutoresizingMaskIntoConstraints = false
        mondayButton.backgroundColor = UIColor.deepBlue()
        mondayButton.setTitle("M", for: .normal)
        addSubview(mondayButton)
        
        let top = NSLayoutConstraint(item: mondayButton, attribute: .top, relatedBy: .equal, toItem: sundayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: mondayButton, attribute: .leading, relatedBy: .equal, toItem: sundayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: mondayButton, attribute: .bottom, relatedBy: .equal, toItem: sundayButton, attribute: .bottom, multiplier: 1, constant: 0)
          let width = NSLayoutConstraint(item: mondayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }

    func configureTuesdayButton() {
        tuesdayButton.translatesAutoresizingMaskIntoConstraints = false
        tuesdayButton.backgroundColor = UIColor.deepBlue()
        tuesdayButton.setTitle("Tu", for: .normal)
        addSubview(tuesdayButton)
        
        let top = NSLayoutConstraint(item: tuesdayButton, attribute: .top, relatedBy: .equal, toItem: mondayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: tuesdayButton, attribute: .leading, relatedBy: .equal, toItem: mondayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tuesdayButton, attribute: .bottom, relatedBy: .equal, toItem: mondayButton, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: tuesdayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }

    func configureWednesdayButton() {
        wednesdayButton.translatesAutoresizingMaskIntoConstraints = false
        wednesdayButton.backgroundColor = UIColor.deepBlue()
        wednesdayButton.setTitle("W", for: .normal)
        addSubview(wednesdayButton)
        
        let top = NSLayoutConstraint(item: wednesdayButton, attribute: .top, relatedBy: .equal, toItem: tuesdayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: wednesdayButton, attribute: .leading, relatedBy: .equal, toItem: tuesdayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: wednesdayButton, attribute: .bottom, relatedBy: .equal, toItem: tuesdayButton, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: wednesdayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }
    
    func configureThursdayButton() {
        thursdayButton.translatesAutoresizingMaskIntoConstraints = false
        thursdayButton.backgroundColor = UIColor.deepBlue()
        thursdayButton.setTitle("Th", for: .normal)
        addSubview(thursdayButton)
        
        let top = NSLayoutConstraint(item: thursdayButton, attribute: .top, relatedBy: .equal, toItem: wednesdayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: thursdayButton, attribute: .leading, relatedBy: .equal, toItem: wednesdayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: thursdayButton, attribute: .bottom, relatedBy: .equal, toItem: wednesdayButton, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: thursdayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }
    
    func configureFridayButton() {
        fridayButton.translatesAutoresizingMaskIntoConstraints = false
        fridayButton.backgroundColor = UIColor.deepBlue()
        fridayButton.setTitle("F", for: .normal)
        addSubview(fridayButton)
        
        let top = NSLayoutConstraint(item: fridayButton, attribute: .top, relatedBy: .equal, toItem: thursdayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: fridayButton, attribute: .leading, relatedBy: .equal, toItem: thursdayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: fridayButton, attribute: .bottom, relatedBy: .equal, toItem: thursdayButton, attribute: .bottom, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: fridayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width])
    }

    func configureSaturdayButton() {
        saturdayButton.translatesAutoresizingMaskIntoConstraints = false
        saturdayButton.backgroundColor = UIColor.deepBlue()
        saturdayButton.setTitle("Sa", for: .normal)
        addSubview(saturdayButton)
        
        let top = NSLayoutConstraint(item: saturdayButton, attribute: .top, relatedBy: .equal, toItem: fridayButton, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: saturdayButton, attribute: .leading, relatedBy: .equal, toItem: fridayButton, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: saturdayButton, attribute: .bottom, relatedBy: .equal, toItem: fridayButton, attribute: .bottom, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: saturdayButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: saturdayButton, attribute: .width, relatedBy: .equal, toItem: sundayButton, attribute: .width, multiplier: 1, constant: 0)
        
        addConstraints([top, leading, bottom, width, trailing])
    }
}
