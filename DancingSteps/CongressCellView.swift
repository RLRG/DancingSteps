//
//  CongressesCellView.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

protocol CongressCellView {
    func display(name: String, imageUrl: String) // TRICKY !!! We don't want to include the logic of the transformation in the view !
}
