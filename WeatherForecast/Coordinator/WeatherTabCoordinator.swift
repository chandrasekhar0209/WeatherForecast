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
                                                target: self,
                                                action: #selector(weatherTabController.rightButtonAction(sender:)))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(weatherTabController.rightButtonAction(sender:)))

        let navigationProperties = NavigationControllerProperties(rootController: weatherTabController,
                                                                  title: "Bookmark",
                                                                  leftBarItems: [leftBarButtonItem],
                                                                  rightBarItems: [rightBarButtonItem])
        window?.rootViewController = UINavigationController.withProperties(navigationProperties)
        window?.makeKeyAndVisible()
    }
}
