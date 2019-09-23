//
//  Task.swift
//  LifeList
//
//  Created by Thalles Marchetti on 14/09/19.
//  Copyright © 2019 Thalles Marchetti. All rights reserved.
//

import UIKit

class Task {
    
    let title: String
    let dueDate: Date
    let type: TaskType
    
    init(title: String, dueDate: Date, type: TaskType) {
        self.title = title
        self.dueDate = dueDate
        self.type = type
    }
}
