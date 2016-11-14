//
//  BookListViewController.swift
//  Biblio
//
//  Created by Adam on 10/28/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

struct Constants {
    static let CellMargin: CGFloat = 14.0
}

class BookListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    lazy var realm = try! Realm()
    lazy var books: Results<Book> = { [unowned self] in
        self.realm.objects(Book.self).filter("currentPage < totalPages")
    }()
    
    let slideAnimationController = VerticalSlideAnimationController()
    var notificationToken: NotificationToken? = nil
    
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
    
    deinit {
        notificationToken?.stop()
    }

    // MARK: - Action
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let addBookVC = AddBookViewController()
        let navigationController = NavigationController(rootViewController: addBookVC)
        navigationController.isNavigationBarHidden = true
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = self
        present(navigationController, animated: true, completion: nil)
        
    }
    
    // MARK: - Setup
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width - (Constants.CellMargin * 2)
        let height = UIScreen.main.bounds.height * 0.3
        layout.itemSize = CGSize(width: width, height: height)
        
        collectionView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(UINib(nibName: BookListCell.Identifier, bundle: nil), forCellWithReuseIdentifier: BookListCell.Identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
    }
}

extension BookListViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSAttributedString(string: "Reading List")
        return string
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = NSAttributedString(string: "The books you're reading go here. Tap + to add a new book.")
        return string
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage(named: "literature")
        return image
    }
    
}

extension BookListViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return books.count == 0
    }

}

extension BookListViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = books[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCell.Identifier, for: indexPath) as! BookListCell
        
        cell.delegate = self
        cell.book = book
        cell.animateProgress()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
}

extension BookListViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BookDetailViewController()
        let book = books[indexPath.row]
        vc.book = book
        let navigationController = NavigationController(rootViewController: vc)
        navigationController.isNavigationBarHidden = true
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
}

extension BookListViewController: UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimationController.isPresenting = true
        return slideAnimationController;
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideAnimationController.isPresenting = false
        return slideAnimationController
    }
}

extension BookListViewController: BookListCellDelegate {
    
    // MARK: - BookListCellDelegate
    
    func moreButtonPressed(cell: BookListCell) {
        let indexPath = collectionView.indexPath(for: cell)!
        let book = books[indexPath.row]
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [unowned self] (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action) in
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
