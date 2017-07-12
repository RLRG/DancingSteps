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


class CompleteVideoViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties & Initialization
    
    var nextButton: UIButton!
    var titleTextField: UITextField!
    
    var videoURL: URL?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    var presenter: CompleteVideoPresenter!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL!)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        nextButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y: view.frame.height - 160.0, width: 100.0, height: 30.0))
        nextButton.setImage(#imageLiteral(resourceName: "nextButton"), for: UIControlState())
        nextButton.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        titleTextField = UITextField(frame: CGRect(x: view.frame.midX - 50, y: view.frame.height - 400.0, width: 200.0, height: 75.0))
        titleTextField.center = self.view.center
        titleTextField.placeholder = "Set the title of the video"
        titleTextField.borderStyle = UITextBorderStyle.line
        titleTextField.backgroundColor = UIColor.white
        titleTextField.textColor = UIColor.blue
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    
    // MARK: - Logic & Actions
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }

    @objc fileprivate func nextButtonAction(_ sender: Any) {
        presenter.saveVideo(title: titleTextField.text!, videoURL: videoURL!)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
