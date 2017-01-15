//
//  NotesMainViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit


/*var folderList: [FoldersModel] = [FoldersModel(name: "AFolder", notes: notesList),FoldersModel(name: "BFolder", notes:notesList)]*/
var folderList : [FoldersModel] = []
var filterFolderList: [FoldersModel] = []

class NotesMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    @IBOutlet weak var notesMainTableView: UITableView!

    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.notesMainTableView)
        if notesMainTableView.indexPathForRow(at: touchPoint) != nil {
            let indexPath = notesMainTableView.indexPathForRow(at: touchPoint)
            let str = folderList[(indexPath?.row)!].name
            // print(indexPath?.row)
            let alertController = UIAlertController(title: "Rename Folder", message: "Enter a new name for this folder", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            let okAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) {
                (action: UIAlertAction!) -> Void in
                let login = (alertController.textFields?.first)! as UITextField
                if let temp = login.text {
                    if !temp.isEmpty {
                        folderList[(indexPath?.row)!].name = temp
                        self.notesMainTableView.reloadData()
                    }
                }
            }
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = str
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
//    folderList = [FoldersModel(name: "AFolder"),FoldersModel(name: "BFolder")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/notes.dat"
        print(filePath)
        
        if let result : NSMutableArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? NSMutableArray{
            
            var folder : String = ""
            var notesList : [NotesModel] = []
            var title_t : String = ""
            var content_t : String = ""
            var count : Int
            var i : Int
            i = 0
            while i < result.count {
                notesList = []
                folder = result[i] as! String
                print(folder)
                i = i + 1
                count = Int((result[i] as! NSString).intValue)
                i = i + 1
                
                for j in 0 ..< count {
                    print("in")
                    title_t = result[i] as! String
                    print(title_t)
                    i = i + 1
                    content_t = result[i] as! String
                    print(content_t)
                    i = i + 1
                    notesList.append(NotesModel(title: title_t, content: content_t))
                }
                folderList.append(FoldersModel(name: folder, notes: notesList))
                
            }
            
        }

        notesMainTableView.delegate = self
        notesMainTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.frame.size.height = 40
        definesPresentationContext = true
        notesMainTableView.tableHeaderView = searchController.searchBar
        
        // hide the search bar
        var contentOffset = notesMainTableView.contentOffset
        contentOffset.y += searchController.searchBar.frame.size.height
        notesMainTableView.contentOffset = contentOffset
        
        // Do any additional setup after loading the view.
    }


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterFolderList.count
        }
        else {
            return folderList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notesMainTableView.dequeueReusableCell(withIdentifier: "NotesCell")! as UITableViewCell
//        let cell = UITableViewCell()
        let title = cell.viewWithTag(101) as! UILabel
        var temp: FoldersModel
        if searchController.isActive && searchController.searchBar.text != "" {
            temp = filterFolderList[indexPath.row]
        }
        else {
            temp = folderList[indexPath.row]
        }
        title.text = temp.name
//        cell.textLabel?.text = temp.title
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNotes" {
            let notes = segue.destination as! NotesSecondViewController
            let indexPath = notesMainTableView.indexPathForSelectedRow
            if let index = indexPath {
                showList = folderList[index.row].notes
                notes.folderIndex = index.row
//                notes.folderName = folderList[index.row].name
            }
//            let note = sender as! NotesModel
//            detail.label = note.title
        }
    }
    
    
    @IBAction func edit(_ sender: Any) {
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) {
            (action: UIAlertAction!) -> Void in
            let login = (alertController.textFields?.first)! as UITextField
            if let temp = login.text {
                if !temp.isEmpty {
                    folderList.append(FoldersModel(name: temp, notes: []))
                    
                    let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/notes.dat"
                    print(filePath)
                    var array = NSMutableArray()
                    var num = 0
                    for item in folderList {
                        array.insert(item.name, at: num)
                        num = num + 1
                        array.insert(item.notes.count.description, at: num)
                        num = num + 1
                        print(item.notes.count)
                        for var i in 0 ..< item.notes.count {
                            array.insert(item.notes[i].title, at: num)
                            num = num + 1
                            array.insert(item.notes[i].content, at: num)
                            num = num + 1
                            i = i + 1
                        }
                    }
                    NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
                    
                    self.notesMainTableView.reloadData()
                }
            }
        }
        
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesMainTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let folder = folderList.remove(at: sourceIndexPath.row)
        folderList.insert(folder, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            folderList.remove(at: indexPath.row)
            
            let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/notes.dat"
            print(filePath)
            var array = NSMutableArray()
            var num = 0
            for item in folderList {
                array.insert(item.name, at: num)
                num = num + 1
                array.insert(item.notes.count.description, at: num)
                num = num + 1
                print(item.notes.count)
                for var i in 0 ..< item.notes.count {
                    array.insert(item.notes[i].title, at: num)
                    num = num + 1
                    array.insert(item.notes[i].content, at: num)
                    num = num + 1
                    i = i + 1
                }
            }
            NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @IBAction func close(_ segue: UIStoryboardSegue) {
        print("closed!")
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContent(searchText: self.searchController.searchBar.text! )
    }
    
    func filterContent(searchText:String) {
        filterFolderList = folderList.filter { n in
            let name = n.name
            return (name.contains(searchText))
        }
        notesMainTableView.reloadData()
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
