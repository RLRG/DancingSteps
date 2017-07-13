//
//  VideoTableViewCell.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
}

extension VideoTableViewCell : VideoCellView {
    func display(name: String) {
        textLabel?.text = name
    }
}
