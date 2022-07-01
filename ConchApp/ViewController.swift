//
//  ViewController.swift
//  ConchApp
//
//  Created by Scholar on 6/28/22.
// I was here -Nabiha

//isah is so cool!!

import UIKit

class ViewController: UIViewController {
    
    var allTheFrenchCanadianTasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nimbusMessageLabel.text = ""
        getMessages()
        genMessage()
        
        getTasks()
        getNextThree()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMessages()
        genMessage()
        getNextThree()
    }
    
    
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!

    let nimbusMessages = ["go at your own pace, we'll handle the rest :)", "hello friend :)", "keep going! you got this!"]
    
    var messageArr : [Message] = []
    
    func getMessages() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataMessages = try? context.fetch(Message.fetchRequest()) as? [Message]
            {
                messageArr =  coreDataMessages
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear \(messageArr)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? AddMessageViewController
        {
            nextVC.vc = self
        }
    }
    
    func genMessage()
    {
        let randNum = Int.random(in : 0..<(messageArr.count + nimbusMessages.count))
        if (randNum < messageArr.count)
        {
            nimbusMessageLabel.text = messageArr[randNum].name
        }
        else
        {
            nimbusMessageLabel.text = nimbusMessages[randNum - messageArr.count]
        }
    }
    
    @IBOutlet weak var nimbusMessageLabel: UILabel!
    
    func getTasks()
    {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            if let coreDataTasks = try? context.fetch(Task.fetchRequest()) as? [Task]
            {
                print("core data tasks fetched")
                print(coreDataTasks)
                allTheFrenchCanadianTasks = coreDataTasks
                print(allTheFrenchCanadianTasks)
            }
        }
    }
    
    func getNextThree()
    {
        getTasks()
        
        print(allTheFrenchCanadianTasks)
         
        if (allTheFrenchCanadianTasks == nil || allTheFrenchCanadianTasks.count == 0)
        {
            print("is it here???")
            labelOne.text = "no upcoming tasks"
            labelTwo.text = "no upcoming tasks"
            labelThree.text = "no upcoming tasks"
        }
        else
        {
            print(allTheFrenchCanadianTasks)
            
            labelTwo.text = "no upcoming tasks"
            labelThree.text = "no upcoming tasks"
            
//            var firstTask = allTheFrenchCanadianTasks[0]
//
//            for task in (allTheFrenchCanadianTasks)
//            {
//                print(task)
//                let firstTaskTime = Double((firstTask.date?.timeIntervalSinceNow)!)
//                let currentTaskTime = Double((task.date?.timeIntervalSinceNow)!)
//
//                if (currentTaskTime > 0 && currentTaskTime < firstTaskTime)
//                {
//                    firstTask = task
//                }
//            }
//            let firstTaskTime = Double((firstTask.date?.timeIntervalSinceNow)!)
//
//
//            var secondTask = allTheFrenchCanadianTasks[0]
//            for task in (allTheFrenchCanadianTasks)
//            {
//                let secondTaskTime = Double((secondTask.date?.timeIntervalSinceNow)!)
//                let currentTaskTime = Double((task.date?.timeIntervalSinceNow)!)
//
//                if (currentTaskTime > 0 && currentTaskTime < secondTaskTime && currentTaskTime > firstTaskTime)
//                {
//                    secondTask = task
//                }
//            }
//            let secondTaskTime = Double((firstTask.date?.timeIntervalSinceNow)!)
//
//
//            var thirdTask = allTheFrenchCanadianTasks[0]
//            for task in (allTheFrenchCanadianTasks)
//            {
//                let thirdTaskTime = Double((thirdTask.date?.timeIntervalSinceNow)!)
//                let currentTaskTime = Double((task.date?.timeIntervalSinceNow)!)
//
//                if (currentTaskTime > 0 && currentTaskTime < thirdTaskTime && currentTaskTime > firstTaskTime && currentTaskTime > secondTaskTime)
//                {
//                    thirdTask = task
//                }
//            }
//
//            labelOne.text = getTaskString(task : firstTask)
//            if ((allTheFrenchCanadianTasks.count) > 1)
//            {
//                labelTwo.text = getTaskString(task : secondTask)
//            }
//            if ((allTheFrenchCanadianTasks.count) > 2)
//            {
//                labelThree.text = getTaskString(task : thirdTask)
//            }
            
            
            let evenMoreSorted = allTheFrenchCanadianTasks.filter({$0.date!.timeIntervalSinceNow >= 0}).sorted(by: { $0.date!.timeIntervalSinceNow < $1.date!.timeIntervalSinceNow })
            
            labelOne.text = getTaskString(task : evenMoreSorted[0])
            if (evenMoreSorted.count > 1)
            {
                labelTwo.text = getTaskString(task : evenMoreSorted[1])
            }
            if (evenMoreSorted.count > 2)
            {
                labelThree.text = getTaskString(task : evenMoreSorted[2])
            }
            
            
        }
        
    }
    
    func getTaskString(task : Task) -> String
    {
        var time = Double((task.date?.timeIntervalSinceNow)!) / 60
        var units = "minutes"
        
        if (time >= 60)
        {
            time /= 60
            units = "hours"
        }
        if (time >= 24)
        {
            time /= 24
            units = "days"
        }
        
        let timeInt = Int(time)
        return ("\(task.name ?? "unnamed task") in \(timeInt) \(units)")
    }
    
}

