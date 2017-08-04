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
    let useCase: GetVideosUseCase
    let disposeBag = DisposeBag()
    
    init(useCase: GetVideosUseCase) {
        self.useCase = useCase
    }
    
    func viewIsReady() {
        useCase.getAllVideosFromDB()
    }
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: VideoCellView, forRowAt row: Int) {
        let video = videos.value[row]
        cell.display(name: video.title)
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
            .addDisposableTo(disposeBag)
    }
}
