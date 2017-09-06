//
//  SaveNewVideoUseCase.swift
//  DancingSteps
//
//  Created by RLRG on 12/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class SaveNewVideoUseCase: SaveNewVideoProtocol {
    
    // MARK: Properties & Initialization
    private let repository: Repository
    private let fileManager: FileManager
    
    let disposeBag = DisposeBag()
    var videoSavedFlag = false
    
    init(repository: Repository, fileManager: FileManager) {
        self.repository = repository
        self.fileManager = fileManager
    }
    
    // MARK: Logic
    
    func saveVideoToDB(title: String, styleId: String, videoURL: URL) -> Observable<Void> {
        
        // Fetching the data. (dependency version principle)
        let completableObservable = Observable<Void>.create { observer in
            do {
                // If we change this flag here, it would mean that the video must be saved once. Note that this implementation is developed meanwhile the problem of the method "query" is fixed. This is temporary then.
                self.videoSavedFlag = false
                
                let documentsPath =  self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                let writePath = documentsPath.appendingPathComponent(title).appendingPathExtension("mov")
                
                var video : Video? = nil
                if (self.fileManager.fileExists(atPath: writePath.path)) {
                    observer.onError(RecordingError.existingVideoName)
                } else {
                    try self.fileManager.moveItem(at: videoURL, to: writePath)
                    
                    let styleObservable = self.repository.getDanceStyle(withID: styleId)
                    styleObservable
                        .asObservable()
                        .subscribe(
                            onNext: { (styles) in
                                for style in styles {
                                    if (style.name == styleId && self.videoSavedFlag == false) {
                                        video = Video(id: title, title: title, datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: style)
                                        
                                        let completeVideoObservable = self.repository.save(video!)
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
