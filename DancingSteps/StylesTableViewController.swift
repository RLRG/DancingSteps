//
//  StylesTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import MessageUI
import Realm // TODO: BE CAREFUL ! REMOVE THIS !


class StylesTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - Properties & Initialization
    
    public var presenter: StylesPresenter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        setupDataObserver()

    }
    
    func setupDataObserver() {
        presenter.videos.asObservable()
            .subscribe({_ in 
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    
    // MARK: - Table View data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.videos.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tricky !!
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "styleCell", for: indexPath)
        // Configuration of the data inside of the cell
        presenter.configure(cell: cell as! StyleCellView, forRowAt: indexPath.row)
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implemente Clean architecture !! Give this responsability to the presenter ?
        tableView.deselectRow(at: indexPath, animated: true)
        let testingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestingViewController") as! TestingViewController
        testingVC.videoURL = URL(string: presenter.videos.value[indexPath.row].url)
        self.navigationController?.pushViewController(testingVC, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func sendRealmDBByEmail(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["rlromero@gmv.com"])
        composeVC.setSubject("[iOS Nanodegree] Final project. Realm database")
        composeVC.setMessageBody("Hello this is the Realm local database!", isHTML: false)
        
        print("File path loaded: \(RLMRealmPathForFile("default.realm"))")
            
        if let fileData = NSData(contentsOfFile: RLMRealmPathForFile("default.realm") ) {
            print("File data loaded.")
            composeVC.addAttachmentData(fileData as Data, mimeType: "application/octet-stream", fileName: "default.realm")
        }
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}
