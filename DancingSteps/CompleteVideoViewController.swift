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
import RxSwift


class CompleteVideoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var rootStackView: UIStackView!
    @IBOutlet weak var videoNameTextField: UITextField!
    @IBOutlet weak var stylePickerView: UIPickerView!
    @IBOutlet weak var saveVideoButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var selectedStyleName = ""
    
    var videoURL: URL?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    var presenter: CompleteVideoPresenter!
    let disposeBag = DisposeBag()

    // MARK: - Initialization functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // General
        self.tabBarController?.tabBar.isHidden = true
        videoNameTextField.delegate = self
        stylePickerView.dataSource = self
        stylePickerView.delegate = self
        
        // Keyboard
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(CompleteVideoViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CompleteVideoViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Rounded buttons
        cancelButton.layer.cornerRadius = 10
        saveVideoButton.layer.cornerRadius = 10
        
        // Dance styles
        setupStylesDataObserver()
        presenter.getDanceStyles()
        
        // AVPlayer
        player = AVPlayer(url: videoURL!)
        playerController = AVPlayerViewController()
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        playerController!.player = player!
        self.addChildViewController(playerController!)
        playerController!.view.frame = videoView.frame
        self.rootStackView.addSubview(playerController!.view)
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
    
    func setupStylesDataObserver() {
        presenter.styles.asObservable()
            .subscribe({_ in
                self.stylePickerView.reloadAllComponents()
                
                // Setting the default dance style to the first selected.
                if (!self.presenter.styles.value.isEmpty) {
                    self.selectedStyleName = self.presenter.styles.value[0].name
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Logic & Actions
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    @IBAction func cancelVideoSaving(_ sender: Any) {
        if self.player != nil {
            self.player!.pause()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveVideo(_ sender: Any) {
        if self.player != nil {
            self.player!.pause()
        }
        videoNameTextField.resignFirstResponder()
        presenter.saveVideo(title: videoNameTextField.text!, styleId: selectedStyleName, videoURL: videoURL!)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerView Data Source
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.styles.value.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.styles.value[row].name
    }
    
    // MARK: - UIPickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Setting the dance style to the selected one.
        self.selectedStyleName = presenter.styles.value[row].name
    }
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                DispatchQueue.main.async {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                DispatchQueue.main.async {
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
        }
    }
}

extension CompleteVideoViewController : CompleteVideoProtocol {
    
    func videoSavedSuccessfully() {
        #if DEBUG
            print("The video has been saved successfully!")
        #endif
        
        AlertsManager.alert(caller: self, message: "The video has been saved successfully!") {
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
