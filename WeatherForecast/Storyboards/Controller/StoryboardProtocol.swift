//
//  StoryBoardProtocol.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 20/08/21.
//

import UIKit

protocol StoryboardProtocol {
    func initialiseStoryboard() -> UIStoryboard
    func instantiateStoryboard() -> UIViewController?
}

enum Storybords: String {
    case weatherForecast = "WeatherForecast"
}
