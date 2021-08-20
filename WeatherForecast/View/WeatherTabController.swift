//
//  WeatherTabController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 20/08/21.
//

import UIKit

class WeatherTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Bookmark"
    }
}

extension WeatherTabController {
    @objc func rightButtonAction(sender: Any) {
        
    }
}

extension WeatherTabController: StoryboardProtocol {
    func initialiseStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Storybords.weatherForecast.rawValue, bundle: nil)
    }
    
    func instantiateStoryboard() -> UIViewController? {
        guard let rootVC = initialiseStoryboard().instantiateViewController(identifier: "WeatherTabController") as? WeatherTabController else {
            return nil
        }
        
        return rootVC
    }
}
