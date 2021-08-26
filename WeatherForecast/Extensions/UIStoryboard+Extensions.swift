//
//  UIStoryboard+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 27/08/21.
//

import UIKit

extension UIStoryboard {
    private static func initialiseStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Storybords.weatherForecast.rawValue, bundle: nil)
    }
    
    static func instantiateControllerFromStoryboard<C>(controller: C.Type) -> C? {
        guard let viewController = initialiseStoryboard().instantiateViewController(identifier: "\(C.self)") as? C else {
            return nil
        }
        
        return viewController
    }
}

enum Storybords: String {
    case weatherForecast = "WeatherForecast"
}
