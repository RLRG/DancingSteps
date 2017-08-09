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
        loadingSpinner.color = UIColor.purple
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.startAnimating()
        // QUESTION: Is there a better way to center the activity indicator in the center of the screen ? If I don't do it like this, the activity indicator appears a little bit slightly below of the center position (because of the displacement caused by the navigation bar).
        loadingSpinner.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (self.navigationController?.navigationBar.bounds.height)!)
        disableUserInteractionWithTableView()
        self.tableView.addSubview(loadingSpinner)
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
                self.enableUserInteractionWithTableView()
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
            if (!self.presenter.congresses.value.isEmpty) {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
            }
            self.disableUserInteractionWithTableView()
        }
        presenter.viewIsReady()
    }
    
    func disableUserInteractionWithTableView() {
        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = false
            self.tableView.isUserInteractionEnabled = false
        }
    }
    
    func enableUserInteractionWithTableView() {
        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = true
            self.tableView.isUserInteractionEnabled = true
        }
    }
}

extension CongressesTableViewController : CongressesTableViewProtocol {
    func displayNetworkError () {
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
            self.tableView.isScrollEnabled = true
        }
        AlertsManager.alert(caller: self, message: "An error has happened, the information could not be updated. Check your Internet connection and refresh the information again.", title: "Internet connection problem") {
            #if DEBUG
                print("topEvents network error")
            #endif
        }
    }
}
