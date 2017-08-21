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
    
    private let repository: AbstractRepository<Video>
    var presenter: CompleteVideoPresentation!
    
    let disposeBag = DisposeBag()
    var videoSavedFlag = false
    
    init(repository: AbstractRepository<Video>) {
        self.repository = repository
    }
    
    // MARK: Logic of the interactor.
    
    func saveVideoToDB(title: String, styleId: String, videoURL: URL) {
        
        // If we change this flag here, it would mean that the video must be saved once. Note that this implementation is developed meanwhile the problem of the method "query" is fixed. This is temporary then.
        videoSavedFlag = false
        
        // Fetching the data. (dependency version principle)
        var video: Video? = nil
        do {
            let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let writePath = documentsPath.appendingPathComponent(title).appendingPathExtension("mov")
            
            if (FileManager().fileExists(atPath: writePath.path)) {
                self.presenter.displayError(string: "The name you are trying to set already exists ! Please, choose another one and try again.")
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
                                    video = Video(id: title, title: title, datetime: Date(), videoDescription: "DESCRIPTION TEST", url: "Deprecated", style: style) // TODO: Be careful with this, how to improve it ?
                                    
                                    let completeVideoObservable = self.repository.save(entity: video!)
                                    
                                    // Provide the data to the presenter.
                                    self.presenter.present(finishVideoObservable: completeVideoObservable)
                                    self.videoSavedFlag = true
                                }
                            }
                    })
                    .disposed(by: disposeBag)
                
                #if DEBUG
                    print("movie saved")
                #endif
            }
            
            
        } catch {
            #if DEBUG
                print(error)
            #endif
            self.presenter.displayError(string: error.localizedDescription)
        }
    }
    
    func getDanceStyles() {
        let styleRepo = RealmRepo<Style>()
        let styleObservable = styleRepo.queryAll()
        presenter.loadDanceStyles(finishQueryStyles: styleObservable)
    }
}
