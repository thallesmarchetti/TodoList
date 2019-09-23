//
//  TaskCreatorViewController.swift
//  LifeList
//
//  Created by Thalles Marchetti on 15/09/19.
//  Copyright © 2019 Thalles Marchetti. All rights reserved.
//

import UIKit

protocol TaskCreatorDelegate {
    func didCreatNewTask(task: Task)
}

class TaskCreatorViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var taskTypeTextField: UITextField!
    
    var delegate: TaskCreatorDelegate?
    
    private let taskTypes: [TaskType] = [.coding, .vacationPlanning, .exercice, .infnet]
    
    private var taskTypePickerView: UIPickerView?
    private var dueDatePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        configureTextFields()
        configureTapGestureRecognizer()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func creatTaskTapped(_ sender: Any) {
        
        guard let taskTitle = titleTextField.text, taskTitle.count > 0,
        let taskTypeText = taskTypeTextField.text, taskTypeText.count > 0,
            let dueDateText = dueDateTextField.text, dueDateText.count > 0 else {
                displayError(errorTitle: "Erro", errorMessage: "Preenchimento obrigatório!")
                return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let dueDate = dateFormatter.date(from: dueDateText) else {
            displayError(errorTitle: "Data Inválida", errorMessage: "Favor preencher corretamente")
            return
        }
        
        guard let taskType = TaskType(rawValue: taskTypeText) else {
            displayError(errorTitle: "Tarefa inválida", errorMessage: "Favor preencher corretamente")
            return
        }
        
        let newTask = Task(title: taskTitle, dueDate: dueDate, type: taskType)
        
        delegate?.didCreatNewTask(task: newTask)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    private func displayError(errorTitle: String, errorMessage: String) {
        let errorAlertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            print("The ok")
        }
        
        errorAlertController.addAction(okAction)
        
        present(errorAlertController, animated: true, completion: nil)
    }
    
    
    private func configureTapGestureRecognizer () {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TaskCreatorViewController.didDetectTap(recognizer:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureTextFields() {
        
        taskTypePickerView = UIPickerView()
        
        titleTextField.delegate = self
        dueDateTextField.delegate = self
        
        taskTypeTextField.delegate = self
        taskTypeTextField.inputView = taskTypePickerView
        
        taskTypePickerView?.delegate = self
        taskTypePickerView?.delegate = self
        
        dueDatePicker = UIDatePicker()
        dueDatePicker?.datePickerMode = .date
        dueDatePicker?.addTarget(self, action: #selector(TaskCreatorViewController.dateSelected(datePicker:)), for: .valueChanged)
        
        dueDateTextField.inputView = dueDatePicker
        
    }
    
    @objc func didDetectTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateSelected(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        dueDateTextField.text = formattedDate
        view.endEditing(true)
    }
}

extension TaskCreatorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        taskTypeTextField.text = taskTypes[row].rawValue
        view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let selectedTask = taskTypes[row]
        return selectedTask.rawValue
    }
    
}

extension TaskCreatorViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension TaskCreatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

