//
//  Congress.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RMCongress: Object {
    dynamic var name: String = ""
    dynamic var organizer: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
    dynamic var imageUrl: String = ""
    // TODO: Add location (to improve the app with a map).
}
