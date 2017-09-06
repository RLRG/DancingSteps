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
    
    func getAllVideos() -> Observable<[Video]> {
        return Repository.shared.getAllVideos()
    }
}
