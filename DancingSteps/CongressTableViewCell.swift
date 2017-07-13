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
    @IBOutlet weak var titleLabel: UILabel!
}

extension CongressTableViewCell : CongressCellView {
    
    func display(name: String, imageUrl: String) {
        titleLabel.text = name
        
        // TOD: Improve this !
        if(imageUrl == "") {
            eventImageView.downloadedFrom(url: URL(string:"http://wowslider.com/sliders/demo-34/data1/images/greatwilder1400498.jpg")!)
        } else {
            eventImageView.downloadedFrom(url: URL(string:imageUrl)!)
        }
    }
}
