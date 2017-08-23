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
    dynamic var id: String = ""
    dynamic var title: String = ""
    dynamic var datetime: Date = Date()
    dynamic var videoDescription: String = ""
    dynamic var url: String = ""
    dynamic var style: RMStyle?
    // IMPROVEMENT: Add location (to improve the app with a map).
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


extension RMVideo: DomainConvertibleType {
    func asDomain() -> Video {
        return Video(id: id,
                    title: title,
                    datetime: datetime,
                    videoDescription: videoDescription,
                    url: url,
                    style: style!.asDomain())
    }
}

extension Video: RealmRepresentable {
    func asRealm() -> RMVideo {
        return RMVideo.build { object in
            object.id = id
            object.title = title
            object.datetime = datetime
            object.videoDescription = videoDescription
            object.url = url
            object.style = style.asRealm()
        }
    }
}
