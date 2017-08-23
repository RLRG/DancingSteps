//
//  RealmRepo.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

func abstractMethod() -> Never {
    fatalError("abstract method")
}

class AbstractRepository<T> {
    
    func queryAll() -> Observable<[T]> {
        abstractMethod()
    }
    
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        abstractMethod()
    }
    
    func save(entity: T) -> Observable<Void> {
        abstractMethod()
    }
    
    func delete(entity: T) -> Observable<Void> {
        abstractMethod()
    }
}

final class RealmRepo<T:RealmRepresentable>: AbstractRepository<T> where T == T.RealmType.DomainType, T.RealmType: Object {
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration) // swiftlint:disable:this force_try
    }
    
    init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
        let name = "com.CleanArchitectureRxSwift.RealmRepo"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }
    
    override func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    override func query(with predicate: NSPredicate,
                        sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            // QUESTION: Why the filter method does not work ? I don't understand why.... The following message appears on the top of XCode editor: ""An internal error occurred. Source editor functionality is limited. If you want to check it, just uncomment the line ".filter(predicate)". 
            // For this reason I had to filter the results in code in the file "SaveNewVideoUseCase", check it out ! ;)
            //            The implementation is broken: it cause compiler to crash with xcode 8.3 ¯\_(ツ)_/¯
            //                            .filter(predicate)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
            .subscribeOn(scheduler)
    }
    
    override func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            let realm = self.realm
            return realm.rx.save(entity: entity)
            }.subscribeOn(scheduler)
    }
    
    override func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
            }
            .subscribeOn(scheduler)
    }
}
