//
//  StyleCellView.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

protocol StyleCellView {
    func display(name: String) // TRICKY !!! We don't want to include the logic of the transformation in the view !
}
