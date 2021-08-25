//
//  String+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

extension String {
    static func getClassName<C: UIViewController>(from controller: C) -> String {
        return String(describing: controller.self)
    }
    
    static func temparatureWithDegreeSymbol(value: String) -> String? {
        guard let doubleValue = Double(value) else {
            return nil
        }
        return NSString(format:"%d%@", Int(doubleValue), WeatherSymbols.degree.rawValue) as String
    }
}
