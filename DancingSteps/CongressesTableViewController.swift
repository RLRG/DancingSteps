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
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        presenter.configure(cell: cell as! CongressCellView, forRowAt: indexPath.row) // swiftlint:disable:this force_cast
        return cell
    }

    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implemente Clean architecture !! Give this responsability to the presenter ?
        tableView.deselectRow(at: indexPath, animated: true)
        // swiftlint:disable:next force_cast
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongressDetailsViewController") as! CongressDetailsViewController
        detailsVC.congress = presenter.congresses.value[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

