//
//  Style.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RMStyle: Object {
    dynamic var name: String = ""
    dynamic var country: String = "" // Get them from a web service? Implement it as a enum ? Improve this?
    // TODO: Add more properties?
}
