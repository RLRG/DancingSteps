//
//  CompleteVideoPresentation.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

protocol CompleteVideoPresentation {
    func present(finishVideoObservable: Observable<Void>)
    func displayError(string: String)
}
