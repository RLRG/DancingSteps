//
//  VideosTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 10/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import MessageUI

class VideosTableViewController: UITableViewController {
    
    // MARK: - Properties & Initialization
    
    public var presenter: VideosPresenter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a bar button used to open the Debug screen when we are executing the LAB target.
        #if DancingStepsLAB
            let debugButton = UIBarButtonItem(title: "DEBUG", style: .plain, target: self, action: #selector(VideosTableViewController.openDebugScreen))
            self.navigationItem.rightBarButtonItem  = debugButton
        #endif
        
        setupDataObservers()
        presenter.getDanceStyles()
        presenter.viewIsReady()
    }
    
    func setupDataObservers() {
        
        // Videos
        presenter.videos.asObservable()
            .subscribe({_ in 
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // Dance styles
        presenter.styles.asObservable()
            .subscribe({_ in
                self.tableView.reloadData() // TODO: Is it possible to include in the same observer two different observables ? Or when both of them finish, do what we consider necessary.
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Adding a background view to the table view
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "coupleDancingClear"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    
    // MARK: - Table View data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.styles.value.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.styles.value[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.videos.value
            .filter{ $0.style.name == presenter.styles.value[section].name }.count // swiftlint:disable:this opening_brace
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tricky !!
        // Get the empty cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        // Configuration of the data inside of the cell
        presenter.configure(cell: cell as! VideoCellView, forSectionAt: indexPath.section, forRowAt: indexPath.row) // swiftlint:disable:this force_cast
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implement Clean architecture !! Give this responsability to the presenter ?
        tableView.deselectRow(at: indexPath, animated: true)
        let testingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestingViewController") as! TestingViewController // swiftlint:disable:this force_cast
        testingVC.videoURL = URL(string: presenter.videos.value.filter{ $0.style.name == presenter.styles.value[indexPath.section].name }[indexPath.row].url)
        self.navigationController?.pushViewController(testingVC, animated: true)
    }
    
    // MARK: - Actions
    
    func openDebugScreen() {
        let debugVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DebugViewController") as! DebugViewController // swiftlint:disable:this force_cast
        self.navigationController?.pushViewController(debugVC, animated: true)
    }
}
