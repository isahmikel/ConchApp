//
//  ViewController.swift
//  ConchApp
//
//  Created by Scholar on 6/28/22.
// I was here -Nabiha

//isah is so cool!!

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nimbusMessageLabel.text = ""
        getMessages()
        genMessage()
    }

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
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear \(messageArr)")
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
}

