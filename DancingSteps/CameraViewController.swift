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
    
    var captureButton: UIButton!
    var switchToSelfieButton: UIButton!
    var flashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraDelegate = self
        addButtons()
    }
    
    private func mainConfiguration() {
        flashEnabled = true
    }
    
    private func addButtons() {
        captureButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y: view.frame.height - 160.0, width: 100.0, height: 100.0))
        captureButton.setImage(#imageLiteral(resourceName: "startRecording"), for: UIControlState())
        captureButton.addTarget(self, action: #selector(recordingAction(_:)), for: .touchUpInside)
        self.view.addSubview(captureButton)
        
        switchToSelfieButton = UIButton(frame: CGRect(x: (((view.frame.width / 2 - 37.5) / 2) - 15.0), y: view.frame.height - 100, width: 30.0, height: 23.0))
        switchToSelfieButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: UIControlState())
        switchToSelfieButton.addTarget(self, action: #selector(cameraSwitchAction(_:)), for: .touchUpInside)
        self.view.addSubview(switchToSelfieButton)
        
        let test = CGFloat((view.frame.width - (view.frame.width / 2 + 37.5)) + ((view.frame.width / 2) - 37.5) - 9.0)
        flashButton = UIButton(frame: CGRect(x: test, y: view.frame.height - 100, width: 18.0, height: 30.0))
        flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        flashButton.addTarget(self, action: #selector(toggleFlashAction(_:)), for: .touchUpInside)
        self.view.addSubview(flashButton)
    }
    
    
    // MARK: - Logic
    
    @objc private func recordingAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.captureButton.setImage(#imageLiteral(resourceName: "stopRecording"), for: UIControlState())
        }
        captureButton.removeTarget(self, action: #selector(recordingAction(_:)), for: .touchUpInside)
        captureButton.addTarget(self, action: #selector(stopRecordingAction(_:)), for: .touchUpInside)
        startVideoRecording()
    }
    
    @objc private func stopRecordingAction(_ sender: Any) {
        stopVideoRecording()
        
        // TODO: Implemente Clean architecture !! Give this responsability to the presenter ?
//        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongressDetailsViewController") as! CongressDetailsViewController
//        detailsVC.congress = presenter.congresses.value[indexPath.row]
//        self.navigationController?.pushViewController(detailsVC, animated: true)
        
        DispatchQueue.main.async {
            self.captureButton.setImage(#imageLiteral(resourceName: "startRecording"), for: UIControlState())
        }
        captureButton.removeTarget(self, action: #selector(stopRecordingAction(_:)), for: .touchUpInside)
        captureButton.addTarget(self, action: #selector(recordingAction(_:)), for: .touchUpInside)
    }
    
    @objc private func cameraSwitchAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.switchCamera()
        }
    }
    
    @objc private func toggleFlashAction(_ sender: Any) {
        flashEnabled = !flashEnabled
        
        DispatchQueue.main.async {
            if self.flashEnabled == true {
                self.flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
            } else {
                self.flashButton.setImage(#imageLiteral(resourceName: "withoutFlash"), for: UIControlState())
            }
        }
    }
}
