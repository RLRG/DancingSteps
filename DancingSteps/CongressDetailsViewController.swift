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
    
    // MARK: - Properties
    
    var congress:Congress?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var startsDate: UITextView!
    @IBOutlet weak var endsDate: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Details of the event"
        
        if(congress?.imageUrl == "") {
            imageView.image = #imageLiteral(resourceName: "defaultEvent")
        } else {
            imageView.downloadedFrom(url: URL(string:(congress?.imageUrl)!)!)
        }
        
        self.titleText.text = congress?.name
        self.startsDate.text = DateFormatter.localizedString(from: (congress?.startDate)!, dateStyle: .short, timeStyle: .short)
        self.endsDate.text = DateFormatter.localizedString(from: (congress?.endDate)!, dateStyle: .short, timeStyle: .short)
        self.descriptionTextView.text = congress?.descriptionText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
