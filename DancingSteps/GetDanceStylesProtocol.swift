//
//  GetDanceStylesProtocol.swift
//  DancingSteps
//
//  Created by Rodrigo López-Romero Guijarro on 06/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

public protocol GetDanceStylesProtocol {
    func getDanceStyles() -> Observable<[Style]>
}
