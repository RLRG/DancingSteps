//
//  Network.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

final class Network<T: ImmutableMappable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getRequest(_ path: String) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> [T] in
                return try Mapper<T>().mapArray(JSONObject: json)
            })
    }
    
    func postRequest(_ path: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func putRequest(_ path: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func deleteRequest(_ path: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.delete, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
}
