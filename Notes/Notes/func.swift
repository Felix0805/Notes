//
//  func.swift
//  Notes
//
//  Created by FelixXiao on 2017/1/12.
//  Copyright © 2017年 FelixXiao. All rights reserved.
//

import Foundation

func dateFromString (_ dateStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateStr)
    return date
}


//时间小的排前面，时间相同按优先级排序，
func reminderSort(r1: RemindersModel, r2: RemindersModel) -> Bool{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = NSDate()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd"
    let strNowTime = timeFormatter.string(from: date as Date) as String
    //两者都过期
    var d1: String
    var d2: String
    d1 = formatter.string(from: r1.date)
    d2 = formatter.string(from: r2.date)
    if formatter.string(from: r1.date) < strNowTime {
        d1 = "3"+d1
//        print("d1")
//        print(d1)
    }
    if formatter.string(from: r2.date) < strNowTime {
        d2 = "3" + d2
    }
    if d1 == d2 {
        return r1.level > r2.level
    }
    else {
        return d1 < d2
    }
    
/*    if formatter.string(from: r1.date) < strNowTime && formatter.string(from: r2.date) < strNowTime {
        if formatter.string(from: r1.date) == formatter.string(from: r2.date) {
            return r1.level > r2.level
        }
        else {
            return formatter.string(from: r1.date) < formatter.string(from: r2.date)
        }
    }
    //r1过期
    else if formatter.string(from: r1.date) < strNowTime && formatter.string(from: r2.date) >= strNowTime{
        return true
    }
    //r2过期
    else if formatter.string(from: r2.date) < strNowTime && formatter.string(from: r1.date) >= strNowTime {
        return false
    }
    else {
        if formatter.string(from: r1.date) == formatter.string(from: r2.date) {
            return r1.level > r2.level
        }
        else {
            return formatter.string(from: r1.date) < formatter.string(from: r2.date)
        }
    }*/

}
