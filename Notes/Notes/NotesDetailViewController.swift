//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {

    @IBOutlet weak var abc: NSLayoutConstraint!
    
    @IBOutlet weak var Save: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var deltaY : CGFloat = 0
    var Y: CGFloat = 0
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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    
    
    func keyBoardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            // 计算可能需要上移的距离
            let keyboardHeight = keyboardFrame.origin.y
            let Height = contentTextView.frame.maxY
            deltaY = keyboardHeight - Height
            Y += deltaY
        }
        //    self.view.bringSubview(toFront: NavigationBar)
        abc.constant -= deltaY
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        abc.constant += Y
        Y = 0
    }
    
    
    /*
    // MARK: -

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
