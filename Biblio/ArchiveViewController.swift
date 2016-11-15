//
//  ArchiveViewController.swift
//  Bibliio
//
//  Created by Adam on 10/28/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class ArchiveViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var notificationToken: NotificationToken? = nil

    lazy var realm = try! Realm()
    lazy var books: Results<Book> = { [unowned self] in
        self.realm.objects(Book.self).filter("currentPage == totalPages")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupCollectionView()
        
        notificationToken = books.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) })
                    collectionView.deleteItems(at: deletions.map { IndexPath(row: $0, section: 0) })
                    collectionView.reloadItems(at: modifications.map { IndexPath(row: $0, section: 0) })
                    collectionView.reloadEmptyDataSet()
                }, completion: { _ in })
                break
            case .error(let error):
                print("\(error.localizedDescription)")
                break
            }
        }

    }
    
    // MARK: - Setup
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width - (Constants.BookCell.Margin * 2)
        let height = UIScreen.main.bounds.height * 0.3
        layout.itemSize = CGSize(width: width, height: height)
        
        collectionView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(UINib(nibName: BookListCell.Identifier, bundle: nil), forCellWithReuseIdentifier: BookListCell.Identifier)
        collectionView.dataSource = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
    }

}

extension ArchiveViewController: DZNEmptyDataSetDelegate {
    
    // MARK: - DZNEmptyDataSetDelegate 
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return books.count == 0
    }

}

extension ArchiveViewController: DZNEmptyDataSetSource {
    
    // MARK: - DZNEmptyDataSetSource
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "box")
        return image
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSAttributedString(string: "Archive")
        return string
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSAttributedString(string: "The books you've finished go here.")
        return string
    }
}

extension ArchiveViewController: BookListCellDelegate {
    
    // MARK: - BookListCellDelegate
    
    func moreButtonPressed(cell: BookListCell) {
        let indexPath = collectionView.indexPath(for: cell)!
        let book = books[indexPath.row]
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: Constants.Action.Cancel, style: .cancel) { [unowned self] (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let destroyAction = UIAlertAction(title: Constants.Action.Delete, style: .destructive) { [unowned self] (action) in
            self.realm.beginWrite()
            self.realm.delete(book)
            try! self.realm.commitWrite()
            self.collectionView.reloadEmptyDataSet()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(destroyAction)
        present(alertController, animated: true)
    }
    
}

extension ArchiveViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = books[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCell.Identifier, for: indexPath) as! BookListCell
        
        cell.delegate = self
        cell.book = book
        cell.animateProgress()
        
        return cell
    }
}
