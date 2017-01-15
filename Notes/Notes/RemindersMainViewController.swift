//
//  RemindersMainViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit

var remindersList: [RemindersModel] = []
var filterRemindersList: [RemindersModel] = []

class RemindersMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating{
    
    @IBOutlet weak var RemindersMain: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var fileReminderList:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.txt"
        
        print(filePath)
        
        if let result : NSArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSArray{
            //处理
            var num = 0
            var title1 : String = ""
            var content1 : String = ""
            var level1 = 0
            var date1 : Date = dateFromString("2014-10-20")!
            for item in result {
                if(num % 4 == 0) {
                    title1 = item as! String
                }
                else if(num % 4 == 1) {
                    content1 = (item as! String)
                }
                else if(num % 4 == 2) {
                    print(item as! String)
                    //date1 = dateFromString("2014-10-20")!
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
        RemindersMain.delegate = self
        RemindersMain.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.frame.size.height = 40
        definesPresentationContext = true
        RemindersMain.tableHeaderView = searchController.searchBar
        
        // hide the search bar
        var contentOffset = RemindersMain.contentOffset
        contentOffset.y += searchController.searchBar.frame.size.height
        RemindersMain.contentOffset = contentOffset

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterRemindersList.count
        }
        else {
            return remindersList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.RemindersMain.dequeueReusableCell(withIdentifier: "RemindersCell")! as UITableViewCell
        //        let cell = UITableViewCell()
        let title = cell.viewWithTag(301) as! UILabel
        let dedline = cell.viewWithTag(302) as! UILabel
        let level = cell.viewWithTag(303) as! UILabel
        
        var temp: RemindersModel
        if searchController.isActive && searchController.searchBar.text != "" {
            temp = filterRemindersList[indexPath.row]
        }
        else {
            temp = remindersList[indexPath.row]
        }
        print(indexPath.row)
        title.text = temp.title
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        dedline.text = formatter.string(from: temp.date)
 //        level.text = String(temp.level)
        if temp.level <= 2 {
            level.text = "!"
        }
        else if temp.level <= 4 {
            level.text = "!!"
        }
        else if temp.level <= 6 {
            level.text = "!!!"
        }
        else if temp.level <= 8 {
            level.text = "!!!!"
        }
        else if temp.level <= 10 {
            level.text = "!!!!!"
        }
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let strNowTime = timeFormatter.string(from: date as Date) as String
        print("-------++++")
        print(strNowTime)
        print (formatter.string(from: temp.date))
        if formatter.string(from: temp.date) < strNowTime {
            print("yes")
            title.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 0.5)
            dedline.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 0.5)
            level.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 0.5)
            cell.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 0.3)
        }
        else {
            title.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            dedline.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            level.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            cell.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.5)
        }
        
        
//        RemindersMain.reloadData()
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
            let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/reminders.txt"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContent(searchText: self.searchController.searchBar.text! )
    }
    
    func filterContent(searchText:String) {
        filterRemindersList = remindersList.filter { n in
            let name = n.title
            return (name.contains(searchText))
        }
        RemindersMain.reloadData()
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
