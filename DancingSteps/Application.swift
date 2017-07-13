//
//  Application.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application() // singleton.
    
    func cleanArchitectureConfiguration(storyboard: UIStoryboard, mainWindow: UIWindow) {
        
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController // swiftlint:disable:this force_cast
        
        // VIDEOS
        let s_navigationController = tabBarController.viewControllers?.first as! UINavigationController // swiftlint:disable:this force_cast
        let s_tableViewController = s_navigationController.topViewController as! VideosTableViewController // swiftlint:disable:this force_cast
        let realmRepo = RealmRepo<Video>()
        let getVideosUseCase = GetVideosUseCase(repository: realmRepo)
        let s_presenter = VideosPresenter(useCase: getVideosUseCase)
        getVideosUseCase.presenter = s_presenter
        s_tableViewController.presenter = s_presenter
        
        // RECORDING
        // TODO: Connect the architecture for the recording workflow.
//        let r_navigationController = tabBarController.viewControllers?[1] as! UINavigationController // swiftlint:disable:this force_cast
//        let recordingViewController = r_navigationController.topViewController as! CameraViewController // swiftlint:disable:this force_cast
        //        let realmRepo = RealmRepo<Video>()
        //        let saveNewVideoUseCase = SaveNewVideoUseCase(repository: realmRepo)
        //        let r_presenter = CompleteVideoPresenter(useCase: saveNewVideoUseCase)
        //        // SaveNewVideoUseCase.presenter = r_presenter
        //        s_tableViewController.presenter = s_presenter
        
        // TOP CHART
        let navigationController = tabBarController.viewControllers?[2] as! UINavigationController // swiftlint:disable:this force_cast
        let tableViewController = navigationController.topViewController as! CongressesTableViewController // swiftlint:disable:this force_cast
        let useCaseNetworkProvider = UseCaseNetworkProvider()
        let getCongressesUseCase = useCaseNetworkProvider.makeGetCongressesUseCase()
        let presenter = CongressesPresenter(useCase: getCongressesUseCase)
        getCongressesUseCase.presenter = presenter
        tableViewController.presenter = presenter
        
        // START THE APP !
        mainWindow.rootViewController = tabBarController
        mainWindow.makeKeyAndVisible()
    }
}
