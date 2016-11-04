//
//  BookDetailViewController.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class BookDetailViewController: BaseInputViewController {

    var bookDetailView = BookDetailView()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bookDetailView.tableView.dataSource = self
    }
    
    func setup() {
        configureBookDetailView()
    }
    
    func configureBookDetailView() {
        bookDetailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookDetailView)
        
        let top = NSLayoutConstraint.init(item: bookDetailView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint.init(item: bookDetailView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: bookDetailView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint.init(item: bookDetailView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    // MARK: - IBAction

    @IBAction func editButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
}

extension BookDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "TableViewCell")
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = "You'll finish by"
        
        cell.detailTextLabel?.text = "11/10/16"

        return cell
    }
    
}
