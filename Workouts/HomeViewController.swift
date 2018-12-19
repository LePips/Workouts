//
//  HomeViewController.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/28/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class ThisViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [HomeViewController()]
        
    }
}

class HomeViewController: UIViewController {
    
    var rows: [ExerciseRow] = []
    var filtered: [ExerciseRow] = []
    var searching = false
    var searchController: UISearchController!
    
    private lazy var tableView: UITableView = self._tableView()
    private func _tableView() -> UITableView {
        let tableView = UITableView.forAutoLayout()
        
        view.embed(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        ExerciseRow.configure(tableView)
        
        return tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Exercises"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Dumbbell Flyes"
        self.navigationItem.searchController = searchController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rows = ExerciseRow.buildRows(with: Exercise.parseExercises())
        _ = tableView
        filtered = rows
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = filtered[indexPath.row]
        return row.cell(for: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = filtered[indexPath.row]
        switch row {
        case .exercise(let exercise):
            let vc = ExerciseViewController(with: exercise)
            if searching {
                searching = false
                searchController.navigationController?.pushViewController(vc, animated: true)
            } else {
                 navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filtered = self.rows.filter({ (exercise) -> Bool in
                searching = true
                switch exercise{
                case .exercise(let exercise):
                    return exercise.filter(text)
                }
            })
        } else {
            searching = false
            filtered = rows
        }
        self.tableView.reloadData()
    }
}
