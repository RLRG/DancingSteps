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
    
    var videosTableVC: VideosTableVCProtocol!
    
    let getVideosUseCase: GetVideosProtocol
    let getDanceStylesUseCase: GetDanceStylesProtocol
    
    let disposeBag = DisposeBag()
    
    init(getVideosUseCase: GetVideosProtocol, getDanceStylesUseCase: GetDanceStylesProtocol) {
        self.getVideosUseCase = getVideosUseCase
        self.getDanceStylesUseCase = getDanceStylesUseCase
    }
    
    func viewIsReady() {
        getVideosUseCase.getAllVideos().asObservable()
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
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: VideoCellView, forSectionAt section: Int, forRowAt row: Int) {
        let video = videos.value
            .filter{ $0.style.name == styles.value[section].name }[row] // swiftlint:disable:this opening_brace
        cell.display(name: video.title)
    }
    
    func configureVideoScreen(forIndexAt indexPath: IndexPath) {
        let videoTitle = videos.value
            .filter{ $0.style.name == styles.value[indexPath.section].name }[indexPath.row].title // swiftlint:disable:this opening_brace
        videosTableVC.displayVideoScreen(withVideoTitle: videoTitle)
    }
    
    func getDanceStyles() {
        getDanceStylesUseCase.getDanceStyles().asObservable()
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
