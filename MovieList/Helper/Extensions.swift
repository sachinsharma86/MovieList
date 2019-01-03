//
//  Extensions.swift
//  MovieList
//
//  Created by Sachin on 1/2/19.
//

import Foundation

extension Date {
    
    static func userFriendlyDateString(dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: dateString)
        let formatterUserFriendly = DateFormatter()
        formatterUserFriendly.dateFormat = "MMM dd, YYYY"
        var formattedDate = String()
        if let date = date {
            formattedDate = formatterUserFriendly.string(from: date)
        }
        return formattedDate
    }
    
}
