//
//  VideosPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class VideosPresenter {
    
    var videos: Variable<[Video]> = Variable([])
    var styles: Variable<[Style]> = Variable([])
    let useCase: GetVideosUseCase
    let disposeBag = DisposeBag()
    
    init(useCase: GetVideosUseCase) {
        self.useCase = useCase
    }
    
    func viewIsReady() {
        useCase.getAllVideosFromDB()
    }
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: VideoCellView, forSectionAt section: Int, forRowAt row: Int) {
        let video = videos.value
            .filter{ $0.style.name == styles.value[section].name }[row] // swiftlint:disable:this opening_brace
        cell.display(name: video.title)
    }
    
    func displayVideoScreen(navigationController navigator: UINavigationController, forIndexAt indexPath: IndexPath) {
        // swiftlint:disable:next force_cast
        let displayVideoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayViewController") as! DisplayViewController
        displayVideoVC.videoTitle = videos.value
            .filter{ $0.style.name == styles.value[indexPath.section].name }[indexPath.row].title // swiftlint:disable:this opening_brace
        navigator.pushViewController(displayVideoVC, animated: true)
    }
    
    func displayDebugScreen(navigationController navigator: UINavigationController) {
        // swiftlint:disable:next force_cast
        let debugVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DebugViewController") as! DebugViewController
        navigator.pushViewController(debugVC, animated: true)
    }
    
    func getDanceStyles() {
        useCase.getDanceStyles()
    }
}

extension VideosPresenter : VideosPresentation {
    func present(videosObservable: Observable<[Video]>) {
        videosObservable.asObservable()
            .subscribe(
                onNext: { (videos) in
                    #if DEBUG
                        for video in videos {
                            print("Video: \(video.title)")
                        }
                    #endif
                    self.videos.value = videos
            },
                onError: { (error) in
                    print("ERROR GETTING VIDEOS FROM DB: \(error)")
            },
                onCompleted: {
                    print("onCompleted: Getting videos from DB !")
            })
            .disposed(by: disposeBag)
    }
    
    func loadDanceStyles(finishQueryStyles: Observable<[Style]>) {
        finishQueryStyles
            .asObservable()
            .subscribe(
                onNext: { (returnedStyles) in
                    self.styles.value = returnedStyles
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error querying dance styles.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted querying dance styles.")
                    #endif
            }).disposed(by: disposeBag)
    }
}
