//
//  TodoListTableViewController.swift
//  LifeList
//
//  Created by Thalles Marchetti on 14/09/19.
//  Copyright © 2019 Thalles Marchetti. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    private var dataSource: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TODO List"
        //constructDataSource()
    }
    
//    private func constructDataSource() {
//
//        dataSource.append(Task(title: "Estudando iOS", dueDate: Date(), type: .coding))
//        dataSource.append(Task(title: "Limpando o quarto", dueDate: Date(), type: .coding))
//        dataSource.append(Task(title: "Planejando viajar para Irlanda", dueDate: Date(), type: .vacationPlanning))
//    }
    
    
    @IBAction func creatNewTaskTapped(_ sender: Any) {
    }
    
    private func displayEmptyTableView(message: String) {
        
        let infoLabel = UILabel()
        infoLabel.text = message
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "HelveticaNeue-light", size: 30)
        
        tableView.backgroundView = infoLabel
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataSource.count == 0 {
            displayEmptyTableView(message: "Criar nova tarefa")
        } else {
            tableView.backgroundView = nil
        }
        
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:  indexPath) as? TaskTableViewCell {
            let task = dataSource[indexPath.row]
            tableViewCell.configureWith(task: task)
            cell = tableViewCell
        }
        // tableViewCell.textLabel?.text = dataSource[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let taskCreatorViewController = segue.destination as? TaskCreatorViewController {
            taskCreatorViewController.delegate = self
        }
        
        guard let selectedCell = sender as? UITableViewCell else {
            return
        }
        
        guard let selectedIndexPath = tableView.indexPath(for: selectedCell) else {
            return
        }
        
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        
        detailViewController.task = dataSource[selectedIndexPath.row]
    }
    
}

extension TodoListTableViewController: TaskCreatorDelegate {
    func didCreatNewTask(task: Task) {
        print("New task detected")
        dataSource.append(task)
        tableView.reloadData()
    }
}
