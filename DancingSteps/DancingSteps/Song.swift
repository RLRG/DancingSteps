//
//  Song.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class Song: Object {
    dynamic var title: String = ""
    dynamic var singer: String = ""
    // TODO: Add more properties?
}
