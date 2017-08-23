//
//  CameraPresenter.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 23/08/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit

class CameraPresenter {
    
    var cameraVC : CameraProtocol!
    
    func displayCompleteVideoScreen(navigationController navigator: UINavigationController, videoURL url: URL) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let completeVideoVC = storyboard.instantiateViewController(withIdentifier: "CompleteVideoViewController") as? CompleteVideoViewController else {
            cameraVC.displayError(string: "Unexpected error. Contact the developer of the app.")
            return
        }
        
        completeVideoVC.videoURL = url
        
        // QUESTION: How I could improve or make this more efficient ? It would be nice to have this code in the "Application.swift" file along with the CleanArchitecture configuration code.
        let realmVideoRepo = RealmRepo<Video>()
        let realmStyleRepo = RealmRepo<Style>()
        let saveNewVideoUseCase = SaveNewVideoUseCase(repository: realmVideoRepo)
        let getDanceStylesUseCase = GetDanceStylesUseCase(repository: realmStyleRepo)
        let r_presenter = CompleteVideoPresenter(saveVideoUseCase: saveNewVideoUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        saveNewVideoUseCase.presenter = r_presenter
        getDanceStylesUseCase.presenter = r_presenter
        completeVideoVC.presenter = r_presenter
        r_presenter.completeVideoVC = completeVideoVC
        
        navigator.pushViewController(completeVideoVC, animated: true)
    }
}
