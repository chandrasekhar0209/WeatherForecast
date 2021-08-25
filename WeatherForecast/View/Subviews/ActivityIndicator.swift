//
//  ActivityIndicator.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 25/08/21.
//

import UIKit

class ActivityIndicator: NSObject {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.color = .white
        return activityView
    }()
    
    static var shared: ActivityIndicator = {
        let indicator = ActivityIndicator()
        return indicator
    }()
}

extension ActivityIndicator {
    func startAnimating(on view: UIView) {
        let container = UIView()
        container.tag = 2
        container.bounds = view.bounds
        container.backgroundColor = .black.withAlphaComponent(0.5)
        activityIndicator.center = view.center
        container.addSubview(activityIndicator)
        view.addSubview(container)
        UIView.setEdgesConstraints(for: container, with: view)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(on view: UIView) {
        let viewList = view.subviews.filter { subView in return subView.tag == 2 }
        guard viewList.count > 0, let container = viewList.first else {
            return
        }
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        container.removeFromSuperview()
    }
}
