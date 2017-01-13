//
//  NotesSecondViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/13.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit
var notesList: [NotesModel] = [NotesModel(title: "ANotes", content: "AContent", fname: "AFolder"),
                               NotesModel(title: "BNotes", content: "BContend", fname: "BFolder")]
var showList: [NotesModel] = []

class NotesSecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var folderName = "init";
    
    @IBOutlet weak var notesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
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
        //        cell.textLabel?.text = temp.title
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let notes = segue.destination as! NotesDetailViewController
            let indexPath = notesTableView.indexPathForSelectedRow
            if let index = indexPath {
                notes.titleString = showList[index.row].title
                notes.contentString = showList[index.row].content
                //                notes.folderName = folderList[index.row].name
            }
            //            let note = sender as! NotesModel
            //            detail.label = note.title
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
