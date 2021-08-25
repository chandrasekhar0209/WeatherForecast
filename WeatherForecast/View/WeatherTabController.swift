//
//  WeatherTabController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 20/08/21.
//

import UIKit

class WeatherTabController: UITabBarController {}

extension WeatherTabController {
    @objc func leftButtonAction(sender: UIBarButtonItem) {
        guard let tabControllers = self.viewControllers else {
            return
        }
        for controller in tabControllers {
            if let bookmarksController = controller as? BookmarksViewController {
                bookmarksController.editTable()
                break
            }
        }
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let addNewCity: StoryboardProtocol = AddNewCityViewController()
        guard let addNewCityViewController = addNewCity.instantiateControllerFromStoryboard() else {
            return
        }
        
        self.navigationController?.pushViewController(addNewCityViewController, animated: true)
    }
}

extension WeatherTabController: StoryboardProtocol {
    func initialiseStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Storybords.weatherForecast.rawValue, bundle: nil)
    }
    
    func instantiateControllerFromStoryboard() -> UIViewController? {
        guard let viewController = initialiseStoryboard().instantiateViewController(identifier: "WeatherTabController") as? WeatherTabController else {
            return nil
        }
        
        return viewController
    }
}
