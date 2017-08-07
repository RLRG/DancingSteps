//
//  GetVideos.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class GetVideosUseCase {
    
    private let repository: AbstractRepository<Video>
    var presenter: VideosPresentation!
    
    init(repository: AbstractRepository<Video>) {
        self.repository = repository
    }
    
    func getAllVideosFromDB() {
        let videos = repository.queryAll()
        presenter.present(videosObservable: videos)
    }
    
    func getDanceStyles() {
        let styleRepo = RealmRepo<Style>()
        let styleObservable = styleRepo.queryAll()
        presenter.loadDanceStyles(finishQueryStyles: styleObservable)
    }
}
