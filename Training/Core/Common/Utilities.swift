//
//  Utilities.swift
//  Training
//
//  Created by TimedoorMSI on 23/12/21.
//

import Foundation
import UIKit

func UTCToLocal(date: String, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.dateAPIFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let dt = dateFormatter.date(from: date) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dt)
    }
    
    return ""
}

func dateFormatFromDateString(date: String, format: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = Constants.dateAPIFormat
    
    let dateTime = DateFormatter()
    dateTime.dateFormat = format
    
    if let date = dateFormatterGet.date(from: date) {
        return dateTime.string(from: date)
    }
    
    return ""
}
