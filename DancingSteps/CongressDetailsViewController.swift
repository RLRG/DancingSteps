//
//  CongressDetailsViewController.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit

class CongressDetailsViewController: UIViewController {
    
    var congress:Congress?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var startsDate: UITextView!
    @IBOutlet weak var endsDate: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Details of the event"
        
        // TODO: Improve this !
        if(congress?.imageUrl == "") {
            imageView.downloadedFrom(url: URL(string:"https://cdn.evbstatic.com/s3-build/perm_001/48d2e1/django/images/logos/eb_logo_white_1200x1200.png")!)
        } else {
            imageView.downloadedFrom(url: URL(string:(congress?.imageUrl)!)!)
        }
        
        self.titleText.text = congress?.name
        self.startsDate.text = DateFormatter.localizedString(from: (congress?.startDate)!, dateStyle: .short, timeStyle: .short)
        self.endsDate.text = DateFormatter.localizedString(from: (congress?.endDate)!, dateStyle: .short, timeStyle: .short)
    }
    
}
