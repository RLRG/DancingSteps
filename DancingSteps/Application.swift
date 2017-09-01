//
//  Application.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import Realm
import RxSwift
import UIKit

final class Application {
    static let shared = Application() // singleton.
    
    func cleanArchitectureConfiguration(storyboard: UIStoryboard, mainWindow: UIWindow) {
        
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController // swiftlint:disable:this force_cast
        tabBarController.tabBar.barTintColor = UIColor.purple
        
        // VIDEOS
        let s_navigationController = tabBarController.viewControllers?.first as! UINavigationController // swiftlint:disable:this force_cast
        s_navigationController.navigationBar.barTintColor = UIColor.purple
        let s_tableViewController = s_navigationController.topViewController as! VideosTableViewController // swiftlint:disable:this force_cast
        let realmVideosRepo = RealmRepo<Video>()
        let realmStylesRepo = RealmRepo<Style>()
        let getVideosUseCase = GetVideosUseCase(repository: realmVideosRepo)
        let getDanceStylesUseCase = GetDanceStylesUseCase(repository: realmStylesRepo)
        let s_presenter = VideosPresenter(getVideosUseCase: getVideosUseCase, getDanceStylesUseCase: getDanceStylesUseCase)
        s_tableViewController.presenter = s_presenter
        
        // RECORDING
        let r_navigationController = tabBarController.viewControllers?[1] as! UINavigationController // swiftlint:disable:this force_cast
        let recordingViewController = r_navigationController.topViewController as! CameraViewController // swiftlint:disable:this force_cast
        let r_presenter = CameraPresenter()
        r_presenter.cameraVC = recordingViewController
        recordingViewController.presenter = r_presenter
        
        // TOP CHART
        let navigationController = tabBarController.viewControllers?[2] as! UINavigationController // swiftlint:disable:this force_cast
        navigationController.navigationBar.barTintColor = UIColor.purple
        let tableViewController = navigationController.topViewController as! CongressesTableViewController // swiftlint:disable:this force_cast
        let useCaseNetworkProvider = UseCaseNetworkProvider()
        let getCongressesUseCase = useCaseNetworkProvider.makeGetCongressesUseCase()
        let presenter = CongressesPresenter(useCase: getCongressesUseCase)
        presenter.congressesView = tableViewController
        tableViewController.presenter = presenter
        
        // START THE APP !
        mainWindow.rootViewController = tabBarController
        mainWindow.makeKeyAndVisible()
    }
    
    func initializeRealmDatabase() {
        
        // Dance styles
        let realmRepo = RealmRepo<Style>()
        //let disposeBag = DisposeBag() --> Unknown behaviour. Fix this !
        
        let salsa = Style(name: "Salsa", country: "Cuba")
        let bachata = Style(name: "Bachata", country: "Rep.Dominicana")
        let kizomba = Style(name: "Kizomba", country: "Angola")
        let stylesArray = [salsa, bachata, kizomba]
        
        for style in stylesArray {
            let styleObservable = realmRepo.save(entity: style)
            styleObservable
                .subscribe( // QUESTION: Unknown behaviour, If I dispose the observable, the data is not written in the local Realm database. Why does this happen?
                    onNext: { (styleNext) in
                        #if DEBUG
                            print("New style: \(styleNext)")
                        #endif
                })
            //.disposed(by: disposeBag) --> Unknown behaviour. Fix this !
        }
    }
}
