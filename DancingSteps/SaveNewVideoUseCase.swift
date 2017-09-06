//
//  SaveNewVideoUseCase.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class SaveNewVideoUseCase {
    
    // MARK: Properties & Initialization
    
    let disposeBag = DisposeBag()
    var videoSavedFlag = false
    
    // MARK: Logic of the interactor.
    
    func saveVideoToDB(title: String, styleId: String, videoURL: URL) -> Observable<Void> {
        
        // Fetching the data. (dependency version principle)
        let completableObservable = Observable<Void>.create { observer in
            do {
                // If we change this flag here, it would mean that the video must be saved once. Note that this implementation is developed meanwhile the problem of the method "query" is fixed. This is temporary then.
                self.videoSavedFlag = false
                
                let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let writePath = documentsPath.appendingPathComponent(title).appendingPathExtension("mov")
                
                var video : Video? = nil
                if (FileManager().fileExists(atPath: writePath.path)) {
                    observer.onError(RecordingError.existingVideoName)
                } else {
                    try  FileManager.default.moveItem(at: videoURL, to: writePath)
                    
                    let styleRepo = RealmRepo<Style>()
                    let styleObservable = styleRepo.query(with: NSPredicate(format: "name = '\(styleId)'"))
                    styleObservable
                        .asObservable()
                        .subscribe(
                            onNext: { (styles) in
                                for style in styles {
                                    if (style.name == styleId && self.videoSavedFlag == false) {
                                        video = Video(id: title, title: title, datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: style)
                                        
                                        let completeVideoObservable = Repository.shared.save(video!)
                                        completeVideoObservable.asObservable()
                                            .subscribe(
                                                onError: { (error) in
                                                    observer.onError(error)
                                            },
                                                onCompleted: {
                                                    #if DEBUG
                                                        print("movie saved")
                                                    #endif
                                                    self.videoSavedFlag = true
                                                    observer.onCompleted()
                                            }).disposed(by: self.disposeBag)
                                    }
                                }
                        })
                        .disposed(by: self.disposeBag)
                }
            } catch {
                #if DEBUG
                    print(error)
                #endif
                observer.onError(error)
            }
            return Disposables.create()
        }
        
        return completableObservable
    }
}
