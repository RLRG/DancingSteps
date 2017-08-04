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
        
        if(imageUrl == "") {
            eventImageView.image = #imageLiteral(resourceName: "defaultEvent")
        } else {
            eventImageView.downloadedFrom(url: URL(string:imageUrl)!)
        }
    }
}
