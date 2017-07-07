//
//  CongressesTableViewController.swift
//  DancingSteps
//
//  Created by RLRG on 28/06/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import UIKit

class CongressesTableViewController: UITableViewController {

    public var presenter: CongressesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
    }
    
    // MARK: - Table View data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.congresses!.count
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

