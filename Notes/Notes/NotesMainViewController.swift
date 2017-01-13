//
//  NotesMainViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit


var folderList: [FoldersModel] = [FoldersModel(name: "AFolder", notes: notesList),FoldersModel(name: "BFolder", notes:notesList)]


class NotesMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notesMainTableView: UITableView!
    
//    folderList = [FoldersModel(name: "AFolder"),FoldersModel(name: "BFolder")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        notesList = [NotesModel(title: "ANotes", content: "AContent"),
//                     NotesModel(title: "BNotes", content: "BContend")]

        notesMainTableView.delegate = self
        notesMainTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
//        // hide the search bar
//        var contentOffset = notesMainTableView.contentOffset
//        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
//        notesMainTableView.contentOffset = contentOffset
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notesMainTableView.dequeueReusableCell(withIdentifier: "NotesCell")! as UITableViewCell
//        let cell = UITableViewCell()
        let title = cell.viewWithTag(101) as! UILabel
        var temp: FoldersModel
        temp = folderList[indexPath.row]
        title.text = temp.name
//        cell.textLabel?.text = temp.title
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNotes" {
//            let notes = segue.destination as! NotesSecondViewController
            let indexPath = notesMainTableView.indexPathForSelectedRow
            if let index = indexPath {
                showList = folderList[index.row].notes
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
            
            var temp : [NotesModel] = []
            for e in notesList {
                if e.fname != folderList[indexPath.row].name {
                    temp.append(e)
                }
                
            }
            notesList = temp
            folderList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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
