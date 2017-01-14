//
//  NotesSecondViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/13.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit
var notesList: [NotesModel] = [NotesModel(title: "ANotes", content: "AContent"),
                               NotesModel(title: "BNotes", content: "BContend")]
var showList: [NotesModel] = []

class NotesSecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var folderName = "init";
    var folderIndex = 0;
    
    @IBOutlet weak var notesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = editButtonItem
//        showList.removeAll()
        
//        for ele in notesList {
//            if ele.fname == folderName {
//                showList.append(NotesModel(title: ele.title, content: ele.content, fname: ele.fname))
//            }
//        }
//        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notesTableView.dequeueReusableCell(withIdentifier: "noteCell")! as UITableViewCell
        //        let cell = UITableViewCell()
        let title = cell.viewWithTag(201) as! UILabel
        var temp: NotesModel
        temp = showList[indexPath.row]
        
        title.text = temp.title
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let notes = segue.destination as! NotesDetailViewController
            let indexPath = notesTableView.indexPathForSelectedRow
            if let index = indexPath {
                notes.titleString = showList[index.row].title
                notes.contentString = showList[index.row].content
                notes.notesIndex = index.row
            }
        }
        else if segue.identifier == "addNote" {
            let notes = segue.destination as! NotesDetailViewController
            notes.isAdd = 1
        }
    }
    
    @IBAction func close(_ segue: UIStoryboardSegue) {
        print("closed!")
        notesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        folderList[folderIndex].notes = showList
        notesTableView.reloadData()
    }
    
    //edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    //move cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = showList.remove(at: sourceIndexPath.row)
        showList.insert(note, at: destinationIndexPath.row)
    }
    
    //delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            showList.remove(at: indexPath.row)
            folderList[folderIndex].notes = showList
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
