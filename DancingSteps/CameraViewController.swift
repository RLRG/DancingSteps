//
//  CameraViewController.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit
import SwiftyCam

class CameraViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
    
    // MARK: - Properties & Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraDelegate = self
    }

    
    // MARK: - Logic
    
}
