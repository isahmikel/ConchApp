//
//  AddTaskViewController.swift
//  ConchApp
//
//  Created by Isah Vesel on 7/1/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var allTasks : [Task] = []
    
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBAction func addTaskButton(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            
            let task = Task(entity : Task.entity(), insertInto : context)
            
            if let nameText = taskTextField.text
            {
                task.name = nameText
                task.date = taskDatePicker.date
                
                allTasks.append(task)
            }
            
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }

}
