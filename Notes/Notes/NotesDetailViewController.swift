//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {

    
    @IBOutlet weak var Save: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var notesIndex = 0
    var isAdd = 0
    var titleString = "title"
    var contentString = "content"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        titleTextField.text = titleString
        contentTextView.text = contentString
        self.automaticallyAdjustsScrollViewInsets = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveFunc(_ sender: Any) {
        
            print(isAdd)
            if isAdd != 1 {
                notesList[notesIndex].title = titleTextField.text!
                notesList[notesIndex].content = contentTextView.text
            }
            else {
                showList.append(NotesModel(title: titleTextField.text!, content: contentTextView.text))
                isAdd = 0
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
