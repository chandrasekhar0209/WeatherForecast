//
//  String+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

extension String {
    static func getClassName<C>(from controller: C) -> String {
        return String(describing: controller)
    }
    
    static func temparatureWithDegreeSymbol(value: String) -> String? {
        guard let doubleValue = Double(value) else {
            return nil
        }
        return NSString(format:"%d%@", Int(doubleValue), WeatherSymbols.degree.rawValue) as String
    }
    
    static var appName: String {
        return "Weather App"
    }
}
