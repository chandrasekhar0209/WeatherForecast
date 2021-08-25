//
//  WeatherTabCoordinator.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

class WeatherTabCoordinator: CoordinatorProtocol {
    func loadRootViewController(in window: UIWindow?) {
        let weatherTab: StoryboardProtocol = WeatherTabController()
        guard let weatherTabController = weatherTab.instantiateControllerFromStoryboard() as? WeatherTabController else { return }
        
        let leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                style: .plain,
                                                target: weatherTabController,
                                                action: #selector(weatherTabController.leftButtonAction(sender:)))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                 style: .plain,
                                                 target: weatherTabController,
                                                 action: #selector(weatherTabController.rightButtonAction(sender:)))

        let navigationProperties = NavigationControllerProperties(rootController: weatherTabController,
                                                                  title: String.appName,
                                                                  leftBarItems: [leftBarButtonItem],
                                                                  rightBarItems: [rightBarButtonItem])
        window?.rootViewController = UINavigationController.withProperties(navigationProperties)
        window?.makeKeyAndVisible()
    }
}
