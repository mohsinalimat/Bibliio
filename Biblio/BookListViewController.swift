//
//  BookListViewController.swift
//  Biblio
//
//  Created by Adam on 10/28/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        books = [Book.init(title: "Huck Finn", pages: 200), Book.init(title: "Notha book", pages: 30)]
        
        tableView.register(UINib.init(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        
        cell.book = books[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddBookViewController")
            else { return }
        present(vc, animated: true, completion: nil)
        
    }

}
