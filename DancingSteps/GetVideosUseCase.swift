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
    
    init(repository: AbstractRepository<Video>) {
        self.repository = repository
    }
    
    func getAllVideosFromDB() -> Observable<[Video]>{
        return repository.queryAll()
    }
}
