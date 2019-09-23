//
//  TaskTableViewCell.swift
//  LifeList
//
//  Created by Thalles Marchetti on 14/09/19.
//  Copyright © 2019 Thalles Marchetti. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
 
    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var taskSubtitle: UILabel!
    
    func configureWith(task: Task) {
        taskTitle.text = task.title
        taskSubtitle.text = "Tipo: \(task.type.rawValue)"
        
    }
    
}
