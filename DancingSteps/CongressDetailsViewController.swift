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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var organizerLabel: UILabel!
    var congress:Congress?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Details of the event"
        self.nameLabel.text = congress?.name
        self.organizerLabel.text = congress?.organizer
    }
    
}
