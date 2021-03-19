//
//  ViewController.swift
//  Notes
//
//  Created by Екатерина Григорьева on 10.03.2021.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        setTableView()
        setNavBar()
        
        viewModel.loadNotes()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.setFirstNote()
        tableView.reloadData()
        
    }
    
    private func setTableView(){
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorColor = #colorLiteral(red: 0.8246373534, green: 0.5295548439, blue: 1, alpha: 1)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func setNavBar(){
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.title = "N O T E S"
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "liquid"), for: .default)
        setNewNoteButton()
    }
    
    private func setNewNoteButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNoteButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func addNoteButton(){
        let detailVC = DetailPageController()
        
        detailVC.detailModel = viewModel.createNewNote()
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        guard let tableViewCell = cell else { return UITableViewCell() }
        tableViewCell.cellModel = viewModel.cellViewModel(forIndexPath: indexPath)
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPageController()
        
        detailVC.detailModel = viewModel.didSelectRow(at: indexPath.row)
        
        DispatchQueue.main.async { [self] in
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, handler) in
            viewModel.deleteNote(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}


