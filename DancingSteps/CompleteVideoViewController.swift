//
//  CompleteVideoViewController.swift
//  DancingSteps
//
//  Created by RLRG on 11/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class CompleteVideoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoNameTextField: UITextField!
    @IBOutlet weak var stylePickerView: UIPickerView!
    @IBOutlet weak var saveVideoButton: UIButton!
    
    var arrayPickerDataSource = ["Salsa", "Bachata", "Kizomba"] // TODO: Retrieve this information from the database or somewhere else !
    
    var videoURL: URL?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    var presenter: CompleteVideoPresenter!

    // MARK: - Initialization functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // General
        self.tabBarController?.tabBar.isHidden = true
        videoNameTextField.delegate = self
        stylePickerView.dataSource = self
        stylePickerView.delegate = self
        
        // AVPlayer
        player = AVPlayer(url: videoURL!)
        playerController = AVPlayerViewController()
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = videoView.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Logic & Actions
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    @IBAction func saveVideo(_ sender: Any) {
        if self.player != nil {
            self.player!.pause()
        }
        presenter.saveVideo(title: videoNameTextField.text!, videoURL: videoURL!)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerView Data Source
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPickerDataSource[row]
    }
    
    // MARK: - UIPickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension CompleteVideoViewController : CompleteVideoProtocol {
    
    func videoSavedSuccessfully() {
        #if DEBUG
            print("Saved successfully!")
        #endif
        
        AlertsManager.alert(caller: self, message: "Saved successfully") { 
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func errorSavingVideo(error: Error) {
        #if DEBUG
            print(error.localizedDescription)
        #endif
        
        AlertsManager.alert(caller: self, message: "Error: \(error.localizedDescription)") {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
