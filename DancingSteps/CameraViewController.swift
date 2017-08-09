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
        mainConfiguration()
        addButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            self.captureButton.isHidden = true
            self.switchToSelfieButton.isHidden = true
            self.flashButton.isHidden = true
            self.view.isUserInteractionEnabled = false
            AlertsManager.alert(caller: self, message: "The camera is not available in this device and you cannot record any video. Please, install the app in the proper device.", title: "Camera not available") {
                #if DEBUG
                    print("Camera not available")
                #endif
            }
        }
    }
    
    // MARK: - Initial Configuration
    
    private func mainConfiguration() {
        flashEnabled = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func addButtons() {
        captureButton = UIButton(frame: CGRect(x: view.frame.midX - 35, y: view.frame.height - 160.0, width: 75.0, height: 75.0))
        captureButton.setImage(#imageLiteral(resourceName: "startRecording"), for: UIControlState())
        captureButton.addTarget(self, action: #selector(recordingAction(_:)), for: .touchUpInside)
        
        switchToSelfieButton = UIButton(frame: CGRect(x: (((view.frame.width / 2 - 37.5) / 2) - 15.0), y: view.frame.height - 100, width: 30.0, height: 23.0))
        switchToSelfieButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: UIControlState())
        switchToSelfieButton.addTarget(self, action: #selector(cameraSwitchAction(_:)), for: .touchUpInside)
        
        let xRect = CGFloat((view.frame.width - (view.frame.width / 2 + 37.5)) + ((view.frame.width / 2) - 37.5) - 9.0)
        flashButton = UIButton(frame: CGRect(x: xRect, y: view.frame.height - 100, width: 18.0, height: 30.0))
        flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        flashButton.addTarget(self, action: #selector(toggleFlashAction(_:)), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.view.addSubview(self.captureButton)
            self.view.addSubview(self.switchToSelfieButton)
            self.view.addSubview(self.flashButton)
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func recordingAction(_ sender: Any) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.captureButton.alpha = 0.0
            }, completion:{(finished) in
                self.captureButton.setImage(#imageLiteral(resourceName: "stopRecording"), for: .normal)
                UIView.animate(withDuration: 0.25,animations:{
                    self.captureButton.alpha = 1.0
                },completion:nil)
            })

            UIView.animate(withDuration: 0.25, animations: {
                self.flashButton.alpha = 0.0
                self.switchToSelfieButton.alpha = 0.0
            })
        }
        
        captureButton.removeTarget(self, action: #selector(recordingAction(_:)), for: .touchUpInside)
        captureButton.addTarget(self, action: #selector(stopRecordingAction(_:)), for: .touchUpInside)
        
        #if DEBUG
            print("Starting video recording.")
        #endif
        startVideoRecording()
    }
    
    @objc private func stopRecordingAction(_ sender: Any) {
        
        #if DEBUG
            print("Finishing video recording.")
        #endif
        stopVideoRecording()
        
        DispatchQueue.main.async {
            self.captureButton.setImage(#imageLiteral(resourceName: "startRecording"), for: UIControlState())
            UIView.animate(withDuration: 0.25, animations: {
                self.flashButton.alpha = 1.0
                self.switchToSelfieButton.alpha = 1.0
            })
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
    
    // MARK: - SwiftyCam Delegate methods
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        // TODO: Implement Clean architecture !! Give this responsability to the presenter ?
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let completeVideoVC = storyboard.instantiateViewController(withIdentifier: "CompleteVideoViewController") as? CompleteVideoViewController else {
            AlertsManager.alert(caller: self, message: "Unexpected error. Contact the developer of the app.") {
                print("CompleteVideoViewController NOT FOUND")
            }
            return
        }
    
        completeVideoVC.videoURL = url
        
        let realmRepo = RealmRepo<Video>()
        let saveNewVideoUseCase = SaveNewVideoUseCase(repository: realmRepo)
        let r_presenter = CompleteVideoPresenter(useCase: saveNewVideoUseCase)
        saveNewVideoUseCase.presenter = r_presenter
        completeVideoVC.presenter = r_presenter
        r_presenter.completeVideoVC = completeVideoVC // TODO: Clean Architecture: Is this correct ? uhmm... I'm not sure if I meet the specifications of Clean Architecture...
        
        self.navigationController?.pushViewController(completeVideoVC, animated: true)
    }
}
