//
//  DisplayViewController.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DisplayViewController: UIViewController, UITextFieldDelegate {
    
    var videoTitle: String?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITabBarController
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = UIColor.gray
        
        // UINavigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(DisplayViewController.shareVideo))
        
        // Video playback configuration
        let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsPath.appendingPathComponent(videoTitle!).appendingPathExtension("mov")
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    // MAR: - Sharing action
    
    func shareVideo() {
        
        let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsPath.appendingPathComponent(videoTitle!).appendingPathExtension("mov")
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [videoURL], applicationActivities: nil)
        
        // Anything you want to exclude
//        activityViewController.excludedActivityTypes = [
//            UIActivityTypePostToWeibo,
//            UIActivityTypePrint,
//            UIActivityTypeAssignToContact,
//            UIActivityTypeSaveToCameraRoll,
//            UIActivityTypeAddToReadingList,
//            UIActivityTypePostToFlickr,
//            UIActivityTypePostToVimeo,
//            UIActivityTypePostToTencentWeibo
//        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
