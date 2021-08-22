//
//  AddNewCityViewController.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit

class AddNewCityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddNewCityViewController: StoryboardProtocol {
    func initialiseStoryboard() -> UIStoryboard {
        return UIStoryboard(name: Storybords.weatherForecast.rawValue, bundle: nil)
    }
    
    func instantiateControllerFromStoryboard() -> UIViewController? {
        guard let viewController = initialiseStoryboard().instantiateViewController(identifier: "AddNewCityViewController") as? AddNewCityViewController else {
            return nil
        }
        
        return viewController
    }
}
