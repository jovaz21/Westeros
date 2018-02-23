//
//  Date+Additions.swift
//  Westeros
//
//  Created by ATEmobile on 19/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import Foundation

// Init From Formatted String
extension Date {
    init(fromDateString dateString: String, withFormat format: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "En_US_POSIX")
        let d = dateStringFormatter.date(from: dateString)
        self.init(timeInterval: 0, since: d!)
    }
}
