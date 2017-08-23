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
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "coupleDancing"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    
    // MARK: - Table View data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.styles.value.count
    }

    // QUESTION: Why do we need this function and the function viewForHeaderInSection ? If I remove this function, the other one does not get called.
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red: 209/255, green: 196/255, blue: 233/255, alpha: 1) // Purple clear (#d1c4e9 (209,196,233))
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.size.width, height: 25))
        label.text = presenter.styles.value[section].name
        UIFont.boldSystemFont(ofSize: label.font.pointSize)
        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.displayVideoScreen(navigationController: self.navigationController!, forIndexAt: indexPath)
    }
    
    // MARK: - Actions
    
    func openDebugScreen() {
        presenter.displayDebugScreen(navigationController: self.navigationController!)
    }
}
