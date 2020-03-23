//
//  DateExtension.swift
//  Bingo
//
//  Created by luoxiao on 2018/3/6.
//  Copyright © 2018年 EasyVaas. All rights reserved.
//

import Foundation
import UIKit
import DateToolsSwift

public extension Date {
    
    // 10:54
    static func convertToTimeString(_ sec:Int) -> String {
        
        let minute = 60
        let hour = 60 * 60
        let day = 60 * 60 * 24
        
        let t_day = Int(sec / day)
        let t_hour = Int(sec % day / hour)
        let t_minute = Int(sec %  hour / minute)
        let t_sec = Int(sec %  minute)

        if sec <= 0 {
            return "00:00"
        }
        else if sec < minute {
            return String(format: "%02ld", t_sec)
        }
        else if sec < hour {
            return String(format: "%02ld:%02ld", t_minute,t_sec)
        }
        else if sec < day {
            return String(format: "%02ld:%02ld:%02ld", t_hour,t_minute,t_sec)
        }
        else {
            return String(format: "%d天 %02ld:%02ld:%02ld", t_day, t_hour,t_minute,t_sec)
        }
    }
    
}


extension Date {

    enum Format:String {
        case day = "yyyy-MM-dd"
        case dayMinute = "yyyy-MM-dd HH:mm"
        case shorDayMinute = "MM-dd HH:mm"
    }
    
    static func formatToString(_ interval:Int, format:Format) -> String {
        return Date(timeIntervalSince1970: TimeInterval(interval)).format(with: format.rawValue)
    }
}


