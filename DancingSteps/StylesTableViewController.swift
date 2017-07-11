//
//  StylesTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import RxSwift

class StylesTableViewController: UITableViewController {
    
    // MARK: - Properties & Initialization
    
    public var presenter: StylesPresenter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        setupDataObserver()

    }
    
    func setupDataObserver() {
        presenter.styles.asObservable()
            .subscribe({_ in 
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    
    // MARK: - Table View data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.styles.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tricky !!
        
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "styleCell", for: indexPath)
        
        // Configuration of the data inside of the cell
        presenter.configure(cell: cell as! StyleCellView, forRowAt: indexPath.row)
        
        return cell
    }
}
