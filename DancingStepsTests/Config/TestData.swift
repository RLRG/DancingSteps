//
//  TestData.swift
//  DancingStepsTests
//
//  Created by Rodrigo López-Romero Guijarro on 20/09/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

@testable import DancingSteps

struct TestData {
    static let styles: [Style] = [Style(name: "Salsa", country: "Cuba"),
                         Style(name: "Flamenco", country: "España")]
    static let videos: [Video] = [Video(id: "1", title: "1", datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: styles[0]),
                         Video(id: "2", title: "2", datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: styles[1]),
                         Video(id: "3", title: "3", datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: styles[0])]
}
