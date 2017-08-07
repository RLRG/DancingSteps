//
//  CongressesTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 28/06/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit
import RxSwift

class CongressesTableViewController: UITableViewController {

    // MARK: - Properties & Initialization
    
    public var presenter: CongressesPresenter!
    let disposeBag = DisposeBag()
    let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presenter + Observer
        presenter.viewIsReady()
        setupDataObserver()
        
        // UIActivityIndicator
        loadingSpinner.center = view.center
        loadingSpinner.color = UIColor.purple
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.startAnimating()
        self.view.addSubview(loadingSpinner)
    }
    
    func setupDataObserver() {
        presenter.congresses.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Table View data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!presenter.congresses.value.isEmpty) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7 ) { // In 7 seconds while rows are being displayed. // TODO: Improve this activity indicator !
                self.loadingSpinner.stopAnimating()
            }
        }
        return presenter.congresses.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tricky !!
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "congressCell", for: indexPath)
        // Configuration of the data inside of the cell
        self.presenter.configure(cell: cell as! CongressCellView, forRowAt: indexPath.row) // swiftlint:disable:this force_cast
        return cell
    }

    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implement Clean architecture !! Give this responsability to the presenter ?
        tableView.deselectRow(at: indexPath, animated: true)
        // swiftlint:disable:next force_cast
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongressDetailsViewController") as! CongressDetailsViewController
        detailsVC.congress = presenter.congresses.value[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func refreshEventsInfo(_ sender: Any) {
        // Calling the API web service again.
        DispatchQueue.main.async {
            self.loadingSpinner.startAnimating()
        }
        presenter.viewIsReady()
    }
    
}

extension CongressesTableViewController : CongressesTableViewProtocol {
    func displayNetworkError () {
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
        }
        AlertsManager.alert(caller: self, message: "An error has happened, the information could not be updated. Check your Internet connection and refresh the information again.", title: "Internet connection problem") {
            #if DEBUG
                print("topEvents network error")
            #endif
        }
    }
}
