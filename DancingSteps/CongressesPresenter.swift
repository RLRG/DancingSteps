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
    
    var congresses: Variable<[Congress]> = Variable([])
    var congressesView: CongressesTableViewController!
    let useCase: GetCongressesUseCase
    let disposeBag = DisposeBag()
    
    init (useCase: GetCongressesUseCase) {
        self.useCase = useCase
    }
    
    func viewIsReady() {
        useCase.congresses()
    }
    
    // Not a good idea to have a dependency from UIKit, what if we want to have different UI Interfaces?
    func configure(cell: CongressCellView, forRowAt row: Int) {
        let congress = congresses.value[row]
        cell.display(name: congress.name, imageUrl: congress.imageUrl)
    }
    
    func displayEventDetails(navigationController navigator: UINavigationController, forRowAt row: Int) {
        // swiftlint:disable:next force_cast
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongressDetailsViewController") as! CongressDetailsViewController
        detailsVC.congress = congresses.value[row]
        navigator.pushViewController(detailsVC, animated: true)
    }
}

extension CongressesPresenter : CongressesPresentation {
    func present(congressesObservable: Observable<[Congress]>) {
        congressesObservable.subscribe(
            onNext: { (congressArray) in
                #if DEBUG
                    for congress in congressArray {
                        print("Congress: \(congress.name)")
                    }
                #endif
                self.congresses.value = congressArray
            },
            onError: { error in
                #if DEBUG
                    print("ERROR IN RESPONSE (CONGRESS): \(error)")
                #endif
                self.congressesView.displayNetworkError()
            },
            onCompleted: {
                #if DEBUG
                    print("onCompleted event !! (CONGRESS)")
                #endif
            })
            .disposed(by: disposeBag)
    }
}
