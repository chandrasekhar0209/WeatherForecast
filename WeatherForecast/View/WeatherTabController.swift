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
        guard let addNewCityViewController = UIStoryboard.instantiateControllerFromStoryboard(controller: AddNewCityViewController.self) else {
            return
        }
        
        self.navigationController?.pushViewController(addNewCityViewController, animated: true)
    }
}
