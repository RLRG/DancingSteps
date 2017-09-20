//
//  Utils.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 20/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

@testable import DancingSteps

class Utils {
    // Creating an observable sequence
    static func myFrom<T>(_ sequence: [T]) -> Observable<[T]> {
        return Observable.create { observer in
            observer.on(.next(sequence))
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
