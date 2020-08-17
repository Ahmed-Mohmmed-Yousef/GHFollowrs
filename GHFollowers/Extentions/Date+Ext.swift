//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Ahmed on 8/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormate() -> String {
        let dateFormater        = DateFormatter()
        dateFormater.dateFormat = "MMMM yyyy"
        return dateFormater.string(from: self)
    }
}
