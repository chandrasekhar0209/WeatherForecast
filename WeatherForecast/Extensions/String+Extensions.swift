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
}
