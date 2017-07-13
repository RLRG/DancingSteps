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
    
    // MARK: - Properties & Initialization
    var styles: Variable<[Style]> = Variable([])
    var videos: Variable<[Video]> = Variable([])
    
    let useCase: GetVideosUseCase
    let disposeBag = DisposeBag()
    
    init(useCase: GetVideosUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Logic
    
    func viewIsReady() {
        let videosObservable = useCase.getAllVideosFromDB()
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
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    // TODO: BE CAREFUL WITH THE StyleCellView !!
    func configure(cell: VideoCellView, forRowAt row: Int) {
        let video = videos.value[row]
        cell.display(name: video.title)
    }
}
