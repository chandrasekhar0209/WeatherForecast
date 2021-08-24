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
        activityView.tintColor = .white
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
//        container.addSubview(activityIndicator)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(on view: UIView) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
