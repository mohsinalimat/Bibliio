//
//  BookDetailViewController.swift
//  Biblio
//
//  Created by Adam on 11/3/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var pagesReadLabel: UILabel!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var finishDateLabel: UILabel!
    @IBOutlet weak var finishByLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
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
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        cell.textLabel?.text = "You'll finish by"
        
        cell.detailTextLabel?.text = "11/10/16"

        return cell
    }
    
}
