//
//  CongressesTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 28/06/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import RxSwift
#if DancingStepsLAB
    import FLEX
#endif

class CongressesTableViewController: UITableViewController {

    public var presenter: CongressesPresenter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        setupDataObserver()
        
        // Displaying FLEX debugger.
        // TODO: Set up a button only in the LAB target so that the debugger can be opened by the user in real time.
        #if DancingStepsLAB
            FLEXManager.shared().showExplorer()
        #endif
    }
    
    func setupDataObserver() {
        presenter.congresses.asObservable()
            .subscribe(onNext: { congressArray in
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Table View data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.congresses.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tricky !!
        
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "congressCell", for: indexPath)
        
        // Configuration of the data inside of the cell
        presenter.configure(cell: cell as! CongressCellView, forRowAt: indexPath.row)
        
        return cell
    }

}

