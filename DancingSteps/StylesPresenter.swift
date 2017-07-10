//
//  StylesPresenter.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import RxSwift

class StylesPresenter {
    
    // MARK: Properties
    var styles: Variable<[Style]> = Variable([])
    var videos: Variable<[Video]> = Variable([])
    
    let useCase: StylesUseCase
    let disposeBag = DisposeBag()
    
    // MARK: Initialization
    
    init(useCase: StylesUseCase) {
        self.useCase = useCase
    }
    
    // MARK: Logic
    
    func viewIsReady() {
        useCase.showStyles()
    }
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: StyleCellView, forRowAt row: Int) {
        let style = styles.value[row]
        cell.display(name: style.name)
        // The same for the rest of the data.....
    }
}

extension StylesPresenter: StylesPresentation {
    func present(styles: [Style]) {
        #if DEBUG
            for style in styles {
                print("Style: \(style.name)")
            }
        #endif
        self.styles.value = styles
    }
}
