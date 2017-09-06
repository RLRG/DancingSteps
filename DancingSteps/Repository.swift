//
//  Repository.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 06/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class Repository {
    
    // MARK: - Properties & Initialization
    
    static let shared = Repository() // singleton.
    
    private let videoRepo: AbstractRepository<Video>
    private let styleRepo: AbstractRepository<Style>
    
    init() {
        videoRepo = RealmRepo<Video>()
        styleRepo = RealmRepo<Style>()
    }
    
    // MARK: - Realm Local Database
    
    // MARK: Videos
    
    func getAllVideos() -> Observable<[Video]> {
        return videoRepo.queryAll()
    }
    
    func save(_ video: Video) -> Observable<Void> {
        return videoRepo.save(entity: video)
    }
    
    // MARK: Dance styles
    
    func getDanceStyles() -> Observable<[Style]> {
        let styleObservable = styleRepo.queryAll()
        return styleObservable
    }
    
    func save(_ danceStyle: Style) -> Observable<Void> {
        return styleRepo.save(entity: danceStyle)
    }    
}
