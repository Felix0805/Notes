//
//  RemindersModel.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import Foundation

class RemindersModel : NSObject{
    var title: String
    var content:String
    var date: Date
    
    init (title: String, content: String, date: Date) {
        self.title = title
        self.content = title
        self.date = date
    }
}

class NotesModel : NSObject {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

class FoldersModel : NSObject {
    var name: String
    var notes: [NotesModel]
    
    init(name: String, notes: [NotesModel]) {
        self.name = name
        self.notes = notes
    }
}
