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

final class RMVideo: Object {
    dynamic var title: String = ""
    dynamic var datetime: Date = Date()
    dynamic var videoDescription: String = ""
    dynamic var style: RMStyle = RMStyle()
    dynamic var song: RMSong = RMSong()
    dynamic var congress: RMCongress = RMCongress()
    dynamic var dancers: [RMDancer] = []
    // TODO: Add location (to improve the app with a map).
}
