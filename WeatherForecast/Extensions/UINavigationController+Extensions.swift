//
//  UINavigationController+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

struct NavigationControllerProperties {
    let rootViewController: UIViewController
    let leftBarItems: [UIBarButtonItem]?
    let rightBarItems: [UIBarButtonItem]?
}

extension UINavigationController {
    static func withProperties(_ properties: NavigationControllerProperties) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: properties.rootViewController)
        properties.rootViewController.navigationItem.leftBarButtonItems = properties.leftBarItems
        properties.rootViewController.navigationItem.rightBarButtonItems = properties.rightBarItems
        
        return navigationController
    }
}
