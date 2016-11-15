//
//  SettingsViewController.swift
//  Bibliio
//
//  Created by Adam on 11/11/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

final class SettingsViewController: UITableViewController {
    
    let realm = try! Realm()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
            } else if indexPath.row == 1 {
               showEmailInput()
            } else if indexPath.row == 2 {
                
            }
            
        } else {
           confirmEraseData()
        }
    }
    
    // MARK: - UI
    
    private func confirmEraseData() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: Constants.Action.Cancel, style: .cancel) { [unowned self] (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let destroyAction = UIAlertAction(title: "Erase All Data", style: .destructive) { [unowned self] (action) in
            self.realm.beginWrite()
            self.realm.deleteAll()
            try! self.realm.commitWrite()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(destroyAction)
        present(alertController, animated: true)
    }
    
    private func showEmailInput() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients(["adam.tecle@gmail.com"])
        composeVC.setSubject("Bibliio feedback")
        composeVC.setMessageBody("Hello!", isHTML: false)
        
        self.present(composeVC, animated: true, completion: nil)
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
   
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }


}
