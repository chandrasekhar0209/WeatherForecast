//
//  UINavigationController+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import UIKit

struct NavigationControllerProperties {
    let rootViewController: UIViewController
    let title: String?
    let leftBarItems: [UIBarButtonItem]?
    let rightBarItems: [UIBarButtonItem]?
    
    init(rootController: UIViewController, title: String? = nil, leftBarItems: [UIBarButtonItem]? = nil, rightBarItems: [UIBarButtonItem]? = nil) {
        self.rootViewController = rootController
        self.title = title
        self.leftBarItems = leftBarItems
        self.rightBarItems = rightBarItems
    }
}

extension UINavigationController {
    static func withProperties(_ properties: NavigationControllerProperties) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: properties.rootViewController)
        properties.rootViewController.title = properties.title
        properties.rootViewController.navigationItem.leftBarButtonItems = properties.leftBarItems
        properties.rootViewController.navigationItem.rightBarButtonItems = properties.rightBarItems
        
        return navigationController
    }
}
