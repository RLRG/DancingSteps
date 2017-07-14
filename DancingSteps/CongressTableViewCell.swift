//
//  CongressTableViewCell.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit

class CongressTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
}

extension CongressTableViewCell : CongressCellView {
    
    func display(name: String, imageUrl: String) {
        titleTextView.text = name
        
        // TODO: Improve this !
        if(imageUrl == "") {
            eventImageView.downloadedFrom(url: URL(string:"https://cdn.evbstatic.com/s3-build/perm_001/48d2e1/django/images/logos/eb_logo_white_1200x1200.png")!)
        } else {
            eventImageView.downloadedFrom(url: URL(string:imageUrl)!)
        }
    }
}
