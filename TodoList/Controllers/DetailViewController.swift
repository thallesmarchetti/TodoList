//
//  DetailViewController.swift
//  LifeList
//
//  Created by Thalles Marchetti on 14/09/19.
//  Copyright © 2019 Thalles Marchetti. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskTypeLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        
        title = "Task Detail"
    }
    
    private func configureInterface() {
        if let task = task {
            
            taskTitleLabel.text = task.title
            taskTypeLabel.text = task.type.rawValue
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            taskDueDateLabel.text = dateFormatter.string(from: task.dueDate)
        }
    }
    
}
