//
//  DebugViewController.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 03/08/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
#if DancingStepsLAB
    import FLEX
#endif
import Realm

class DebugViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - FLEX Debugger
    
    @IBAction func openFLEX(_ sender: Any) {
        // Displaying FLEX debugger.
        #if DancingStepsLAB
            FLEXManager.shared().showExplorer()
        #endif
    }
    
    // MARK: - Email sending
    
    @IBAction func sendRealmAction(_ sender: Any) {
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
