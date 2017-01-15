//
//  ReminderDetailViewController.swift
//  Notes
//
//  Created by Apple on 2017/1/13.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import Foundation

import UIKit

class RemindersDetailViewController: UIViewController {
    
    
    @IBOutlet weak var ReminderDetail: UIView!
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var contentsItem: UITextView!
    @IBOutlet weak var levelItem: UISlider!
    @IBOutlet weak var dateItem: UIDatePicker!
    
    var reminder: RemindersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(reminder == nil) {
            titleItem.placeholder = "Title"
        }
        else {
            
            titleItem.text = reminder?.title
            contentsItem.text = reminder?.content
            dateItem.setDate((reminder?.date)!, animated: false)
            levelItem.setValue(float_t((reminder?.level)!)/10.0, animated: true)
        }

        let swipe = UISwipeGestureRecognizer(target:self, action:#selector(swipe(_:)))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        let swipe2 = UISwipeGestureRecognizer(target:self, action:#selector(swipe2(_:)))
        swipe2.direction = .right
        self.view.addGestureRecognizer(swipe2)
        
        let swipe3 = UISwipeGestureRecognizer(target:self, action:#selector(swipe3(_:)))
        swipe3.direction = .up
        self.view.addGestureRecognizer(swipe3)
        
        let swipe4 = UISwipeGestureRecognizer(target:self, action:#selector(swipe4(_:)))
        swipe4.direction = .down
        self.view.addGestureRecognizer(swipe4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if(reminder == nil) {
            reminder = RemindersModel(title: titleItem.text!, content: contentsItem.text!, date:dateItem.date, level: Int(levelItem.value * 10))
            remindersList.append(reminder!)

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var array = NSMutableArray()
            var num = 0
            let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.dat"
            remindersList.sort(by: reminderSort)
            for item in remindersList {
                array.insert(item.title, at: num)
                num = num + 1
                array.insert(item.content, at: num)
                num = num + 1
                array.insert(formatter.string(from: item.date), at: num)
                num = num + 1
                array.insert(String(item.level), at: num)
                num = num + 1
            }
            NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
        }
        else {
            reminder?.title = titleItem.text!
            reminder?.content = contentsItem.text!
            reminder?.level = Int(levelItem.value * 10)
            reminder?.date = dateItem.date
            
            
            var array = NSMutableArray()
            var num = 0
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd" 
            
            let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.dat"
            remindersList.sort(by: reminderSort)
            for item in remindersList {
                array.insert(item.title, at: num)
                num = num + 1
                array.insert(item.content, at: num)
                num = num + 1
                array.insert(formatter.string(from: item.date), at: num)
                num = num + 1
                array.insert(String(item.level), at: num)
                num = num + 1
            }
            NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
            
            
        }
    }
    
    
    func swipe(_ recognizer:UISwipeGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func swipe2(_ recognizer:UISwipeGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func swipe3(_ recognizer:UISwipeGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func swipe4(_ recognizer:UISwipeGestureRecognizer){
        self.view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
