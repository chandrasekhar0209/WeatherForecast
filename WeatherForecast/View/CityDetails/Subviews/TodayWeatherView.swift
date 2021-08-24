//
//  TodayWeatherView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

class TodayWeatherView: UIView {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    @IBOutlet weak var cityMaxMinTemperature: UILabel!
    static let nibName = "TodayWeatherView"
    
    func configureView() {
    }
}
