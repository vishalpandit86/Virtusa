//
//  PlanetsViewController.swift
//  PlanetDemo
//
//  Created by Tripathi, Himani on 1/8/19.
//  Copyright © 2019 Tripathi, Himani. All rights reserved.
//

import UIKit

class PlanetsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel = PlanetsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.blue
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data...")
        
        refreshData()
    }
    
    func refreshData() {
        if viewModel.entityIsEmpty(entity: "Asteroids") {
            viewModel.fetchData {
               self.reloadTable()
            }
        } else {
            viewModel.loadData {
                self.reloadTable()
            }
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        viewModel.deleteData {
            self.reloadTable()
        }
    }
    
    @objc func fetchData(_ control: Any ) {
        if viewModel.planets.results.isEmpty {
            refreshData()
        }
        
        self.refreshControl.endRefreshing()
    }
}

extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.planets.results[indexPath.row].name
        return cell
    }
}

