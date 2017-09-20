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
    
    private let videoRepo: AbstractRepository<Video>
    private let styleRepo: AbstractRepository<Style>
    private let networkProvider: NetworkProvider
    
    init(videoRepo: AbstractRepository<Video>, styleRepo: AbstractRepository<Style>, networkProvider: NetworkProvider) {
        self.videoRepo = videoRepo
        self.styleRepo = styleRepo
        self.networkProvider = networkProvider
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
    
    func getDanceStyle(withID id: String) -> Observable<[Style]> {
        return styleRepo.query(with: NSPredicate(format: "name = '\(id)'"))
    }
    
    func save(_ danceStyle: Style) -> Observable<Void> {
        return styleRepo.save(entity: danceStyle)
    }
    
    // MARK: - Network
    
    // MARK: Congresses
    
    func getCongresses() -> Observable<[Congress]> {
        let congressNetwork = networkProvider.makeCongressNetwork()
        return congressNetwork.fetchCongresses()
    }
}
