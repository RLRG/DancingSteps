//
//  CongressTableViewCell.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit

class CongressTableViewCell: UITableViewCell {
    
}

extension CongressTableViewCell : CongressCellView {
    
    func display(name: String) {
        textLabel?.text = name
    }
}
