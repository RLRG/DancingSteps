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
    
    init(repository: AbstractRepository<Video>) {
        self.repository = repository
    }
    
    // MARK: Logic of the interactor.
    
    func saveVideoToDB(title: String, videoURL: URL) {
        
        // 1. Fetching the data. (dependency version principle)
        var video: Video? = nil
        do {
            let documentsPath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let writePath = documentsPath.appendingPathComponent(title).appendingPathExtension("mov")
            try  FileManager.default.moveItem(at: videoURL, to: writePath)
            
            video = Video(id: title, title: title, datetime: Date(), videoDescription: "DESCRIPTION TEST", url: writePath.absoluteString)
            //return repository.save(entity: video)
            
            print("movie saved")
        } catch {
            print(error)
        }
        
        let completeVideoObservable = repository.save(entity: video!)
        
        // 2. Process the data: transformation in order to reduce the data we are going to show in the view.
        //let programmerResponse = programmers.map { ProgrammerResponse(programmer: $0) }
        
        // 3. Provide the data to the presenter.
        presenter.present(finishVideoObservable: completeVideoObservable)
    }
}
