//
//  RemindersMainViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit

var remindersList: [RemindersModel] = []

class RemindersMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var RemindersMain: UITableView!
    
    var fileReminderList:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.dat"
        
        print(filePath)
        /* let array = NSArray(objects: "abcd","efgh","2014-10-2","1","ijk","lmn","2014-10-2","3")
         NSKeyedArchiver.archiveRootObject(array, toFile: filePath)*/
        
        if let result : NSArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSArray{
            //处理
            var num = 0
            var title1 : String = ""
            var content1 : String = ""
            var level1 = 0
            var date1 : Date = dateFromString("2014-10-20")!
            for item in result {
                print("a")
                if(num % 4 == 0) {
                    title1 = item as! String
                }
                else if(num % 4 == 1) {
                    content1 = (item as! String)
                }
                else if(num % 4 == 2) {
                    date1 = dateFromString(item as! String)!
                }
                else if(num % 4 == 3) {
                    level1 = Int(item as! String)!
                    remindersList.append(RemindersModel(title: title1, content: content1, date: date1, level: level1 ))
                    
                }
                num = num + 1

            }
        }
        
        // Do any additional setup after loading the view.
/*                remindersList = [RemindersModel(title: "AReminders", content: "AReminders contents", date:dateFromString("2014-10-20")!, level: 1),
         RemindersModel(title:"BReminders", content: "BReminders contents", date:dateFromString("2014-10-20")!, level: 1)
         ]*/
        RemindersMain.delegate = self
        RemindersMain.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.RemindersMain.dequeueReusableCell(withIdentifier: "RemindersCell")! as UITableViewCell
        //        let cell = UITableViewCell()
        let title = cell.viewWithTag(301) as! UILabel
        let dedline = cell.viewWithTag(302) as! UILabel
        let level = cell.viewWithTag(303) as! UILabel
        
        var temp: RemindersModel
        temp = remindersList[indexPath.row]
        title.text = temp.title
        //        content.text = temp.content
        
/*        let locale = Locale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options:0, locale:locale)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat*/
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        dedline.text = formatter.string(from: temp.date)
        level.text = String(temp.level)
        return cell
    }
    
    
    // MARK - UITableViewDelegate
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            remindersList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var array = NSMutableArray()
            var num = 0
            let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.dat"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        RemindersMain.setEditing(editing, animated: true)
    }
    
    // Move the cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = remindersList.remove(at: sourceIndexPath.row)
        remindersList.insert(temp, at: destinationIndexPath.row)
    }
    
    
    
    @IBAction func close(_ segue: UIStoryboardSegue) {
        print("closed!")
        
        RemindersMain.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RemindersMain.reloadData()
    }
    
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReminderModified" {
            let vc = segue.destination as! RemindersDetailViewController
            // var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            let indexPath = RemindersMain.indexPathForSelectedRow
            if let index = indexPath {
                vc.reminder = remindersList[index.row]
            }
        }
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
