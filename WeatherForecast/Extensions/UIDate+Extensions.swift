//
//  UIDate+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import Foundation

extension Date {
    static let dateFormat: String = {
        return "YYYY-MM-dd HH:mm:ss"
    }()
    static func weatherTimeFormat(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: str)!
        dateFormatter.dateFormat = "h a"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    static func dayFromDate(str: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: str)!
        dateFormatter.dateFormat = "EEEE"
        let string = dateFormatter.string(from: date).capitalized
        return string
    }
    
    static func sunRiseTimeFormat(timeStamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeStamp))
        dateFormatter.dateFormat = "h:mm a"
        let string = dateFormatter.string(from: date as Date)
        return string
    }
}

extension Array {
    func filterDuplicates(includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }

        return results
    }
}

