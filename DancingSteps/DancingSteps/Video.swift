//
//  Video.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class Video: Object {
    dynamic var title: String = ""
    dynamic var datetime: Date = Date()
    dynamic var videoDescription: String = ""
    dynamic var style: Style = Style()
    dynamic var song: Song = Song()
    dynamic var congress: Congress = Congress()
    dynamic var dancers: [Dancer] = []
    // TODO: Add location (to improve the app with a map).
}
