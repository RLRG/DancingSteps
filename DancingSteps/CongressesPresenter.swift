//
//  CongressesPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 04/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class CongressesPresenter {
    
    var congresses: [Congress]?
    let useCase: GetCongressesUseCase
    
    init (useCase: GetCongressesUseCase) {
        self.useCase = useCase
    }
    
    func viewIsReady() {
        useCase.congresses() // TODO: How to communicate this part of the app in Clean Architecture ? Pending to analize it !
    }
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: CongressCellView, forRowAt row: Int) {
        let congress = congresses?[row]
        cell.display(name: (congress?.name)!)
        // The same for the rest of the data.....
    }
}

extension CongressesPresenter : CongressesPresentation {
    func present(congresses: [Congress]) {
        self.congresses = congresses
    }
}
