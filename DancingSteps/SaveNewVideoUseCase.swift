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
    
    init(repository: AbstractRepository<Video>) {
        self.repository = repository
    }
    
    // MARK: Logic of the interactor.
    
    func saveVideoToDB(title: String, styleId: String, videoURL: URL) {
        
        // 1. Fetching the data. (dependency version principle)
        var video: Video? = nil
        do {
            let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let writePath = documentsPath.appendingPathComponent(title).appendingPathExtension("mov")
            try  FileManager.default.moveItem(at: videoURL, to: writePath)
            
            let styleRepo = RealmRepo<Style>()
            let styleObservable = styleRepo.query(with: NSPredicate(format: "name = '\(styleId)'"))
            styleObservable
                .asObservable()
                .subscribe(
                    onNext: { (style) in
                        
                        //let style = Style(name: "test", country: "test")
                        video = Video(id: title, title: title, datetime: Date(), videoDescription: "DESCRIPTION TEST", url: writePath.absoluteString, style: style[0]) // TODO: Be careful with this, how to improve it ?
                        
                        let completeVideoObservable = self.repository.save(entity: video!)
                        
                        // 2. Process the data: transformation in order to reduce the data we are going to show in the view.
                        //let programmerResponse = programmers.map { ProgrammerResponse(programmer: $0) }
                        
                        // 3. Provide the data to the presenter.
                        self.presenter.present(finishVideoObservable: completeVideoObservable)
                })
                .disposed(by: disposeBag)
        
            #if DEBUG
                print("movie saved")
            #endif
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
    }
    
    func getDanceStyles() {
        let styleRepo = RealmRepo<Style>()
        let styleObservable = styleRepo.queryAll()
        presenter.loadDanceStyles(finishQueryStyles: styleObservable)
    }
}
