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
//        fetchTodayForecast(router: .todayForecast(17.38405, 78.45636))
        fetchFiveDayForecast(router: .fiveDayForecast(17.38405, 78.45636))
    }
}

extension CityWeatherDetailsViewController {
    func fetchTodayForecast(router: ForecastRouter)  {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: TodayForecastModel.self) { result in
            switch result {
            case .success(let model):
                guard let todayForecastModel = model as? TodayForecastModel else {
                    return
                }
                
                print(todayForecastModel.cityName ?? "")
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func fetchFiveDayForecast(router: ForecastRouter) {
        cityDetailsViewModel.fetchCityForecast(router: router, codable: FiveDayForecastModel.self) { result in
            switch result {
            case .success(let model):
                guard let todayForecastModel = model as? FiveDayForecastModel else {
                    return
                }
                
                print(todayForecastModel.city?.name ?? "")
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

extension CityWeatherDetailsViewController: StoryboardProtocol {
    func initialiseStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Storybords.weatherForecast.rawValue, bundle: nil)
    }
    
    func instantiateControllerFromStoryboard() -> UIViewController? {
        guard let viewController = initialiseStoryboard().instantiateViewController(identifier: "CityWeatherDetailsViewController") as? CityWeatherDetailsViewController else {
            return nil
        }
        
        return viewController
    }
}
