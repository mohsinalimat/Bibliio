//
//  DayPickerViewController.swift
//  Biblio
//
//  Created by Adam on 11/8/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift

protocol DayPickerDelegate: NSObjectProtocol {
    
    func dayPickerViewController(_ dayPickerViewController: DayPickerViewController, selectedDays: List<BoolObject>?)
    
}

class DayPickerViewController: BaseInputViewController {
    
    weak var delegate: DayPickerDelegate?
    var tableView = UITableView()
    var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    // MARK: - Target Action
    
    dynamic private func saveButtonPressed(_ sender: Any) {
        delegate?.dayPickerViewController(self, selectedDays: selectedDays())
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup
    
    private func setup() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.allowsMultipleSelection = true
        contentView.backgroundColor = .white
        contentView.addSubview(tableView)
        
        let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20)
        tableViewHeightConstraint = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, tableViewHeightConstraint, bottom])
    }
    
    // MARK: - Helper
    
    private func selectedDays() -> List<BoolObject>? {
        guard let selectedRows = tableView.indexPathsForSelectedRows
            else { return nil }
        
        var days = [false, false, false, false, false, false, false]
        for indexPath in selectedRows {
            days[indexPath.row] = true
        }
        
        let list = List<BoolObject>()
        list.append(objectsIn: days.map({ BoolObject(bool:$0) }))
        return list
    }
    
}

extension DayPickerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let day = nameOfDay(forIndex: indexPath.row)
        let cell = UITableViewCell()
        
        cell.textLabel?.text = day
        return cell
    }
    
    private func nameOfDay(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return ""
        }
    }
    
}

extension DayPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
    }
    
}
