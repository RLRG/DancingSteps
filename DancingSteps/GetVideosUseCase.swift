//
//  GetVideos.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class GetVideosUseCase: GetVideosProtocol {
    
    // MARK: - Properties & Initialization
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    func getAllVideos() -> Observable<[Video]> {
        return repository.getAllVideos()
    }
}
