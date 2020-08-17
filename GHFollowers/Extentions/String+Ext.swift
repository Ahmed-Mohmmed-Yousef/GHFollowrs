//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Ahmed on 8/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation
extension String {
    func convertToDate() -> Date? {
        let dateFormater        = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.locale     = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone   = .current
        return dateFormater.date(from: self)
    }
    
    func convertToDisplayFormate() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToMonthYearFormate()
    }
    
    
}
