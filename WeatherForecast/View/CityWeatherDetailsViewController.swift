//
//  CityWeatherDetailsViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import UIKit

class CityWeatherDetailsViewController: UIViewController {
    var cityDetailsViewModel: CityDetailsProtocol

    init(cityDetailsViewModel: CityDetailsProtocol = CityDetailsViewModel()) {
        self.cityDetailsViewModel = cityDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cityDetailsViewModel = CityDetailsViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodayForecast(router: .todayForecast(0, 0))
        fetchFiveDayForecast(router: .fiveDayForecast(0, 0))
    }
}

extension CityWeatherDetailsViewController {
    func fetchTodayForecast(router: ForecastRouter)  {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: BookmarkModel.self) { result in
            
        }
    }
    
    func fetchFiveDayForecast(router: ForecastRouter) {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: BookmarkModel.self) { result in
            
        }
    }
}
