//
//  TrackDateFormatter.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import Foundation

enum TrackDateFormatter{
    static func format(_ s:String) -> String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformatter.locale = Locale(identifier: "en_US_POSIX")
        dateformatter.timeZone = .current
        
        guard let date = dateformatter.date(from: s) else {
            return "Unknown date"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter.string(from: date)
    }
}
