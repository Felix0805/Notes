//
//  NotesMainViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit

var notesList: [NotesModel] = []

class NotesMainViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notesMainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notesList = [NotesModel(title: "ANotes", content: "AContent"),
                     NotesModel(title: "BNotes", content: "BContend")]
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
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.notesMainTableView.dequeueReusableCell(withIdentifier: "NotesCell")! as UITableViewCell
//        let cell = UITableViewCell()
        let title = cell.viewWithTag(101) as! UILabel
        var temp: NotesModel
        temp = notesList[indexPath.row]
        title.text = temp.title
//        cell.textLabel?.text = temp.title
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detail = segue.destination as! NotesDetailViewController
            let indexPath = notesMainTableView.indexPathForSelectedRow
            if let index = indexPath {
                detail.label = notesList[index.row].title
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
