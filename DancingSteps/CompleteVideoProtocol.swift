//
//  CompleteVideoProtocol.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

protocol CompleteVideoProtocol {
    func videoSavedSuccessfully()
    func errorSavingVideo(error: Error)
}
