//
//  WeatherTabCoordinator.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

class WeatherTabCoordinator: CoordinatorProtocol {
    func loadRootViewController(in window: UIWindow?) {
        guard let weatherTabController = UIStoryboard.instantiateControllerFromStoryboard(controller: WeatherTabController.self) else { return }
        if UserDefaultsStorage.shared.units == nil {
            UserDefaultsStorage.shared.units = Units.metric.rawValue
        }
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
