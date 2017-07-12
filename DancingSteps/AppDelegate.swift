//
//  AppDelegate.swift
//  DancingSteps
//
//  Created by RLRG on 28/06/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyBoardName = "Main"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // TODO: Place this configuration in another separate class/file.
        // Configuration
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        
        // STYLES
        let s_navigationController = tabBarController.viewControllers?.first as! UINavigationController
        let s_tableViewController = s_navigationController.topViewController as! StylesTableViewController
        let memoryRepo = InMemoryRepo()
        let stylesUseCase = StylesUseCase(entityGateway: memoryRepo)
        let s_presenter = StylesPresenter(useCase: stylesUseCase)
        stylesUseCase.presenter = s_presenter
        s_tableViewController.presenter = s_presenter
        
        // RECORDING
        let r_navigationController = tabBarController.viewControllers?[1] as! UINavigationController
        let recordingViewController = r_navigationController.topViewController as! CameraViewController
        // TODO: Connect the architecture for the recording workflow.
//        let realmRepo = RealmRepo<Video>()
//        let saveNewVideoUseCase = SaveNewVideoUseCase(repository: realmRepo)
//        let r_presenter = CompleteVideoPresenter(useCase: saveNewVideoUseCase)
//        // SaveNewVideoUseCase.presenter = r_presenter
//        s_tableViewController.presenter = s_presenter
        
        // TOP CHART
        let navigationController = tabBarController.viewControllers?[2] as! UINavigationController
        let tableViewController = navigationController.topViewController as! CongressesTableViewController
        let useCaseNetworkProvider = UseCaseNetworkProvider()
        let getCongressesUseCase = useCaseNetworkProvider.makeGetCongressesUseCase()
        let presenter = CongressesPresenter(useCase: getCongressesUseCase)
        getCongressesUseCase.presenter = presenter
        tableViewController.presenter = presenter
        
        // START THE APP !
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}