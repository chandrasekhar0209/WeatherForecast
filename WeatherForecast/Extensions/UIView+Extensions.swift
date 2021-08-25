//
//  UIView+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 24/08/21.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue
              layer.masksToBounds = (newValue > 0)
        }
    }
    
    static func setEdgesConstraints(for childView: UIView, with parentView: UIView) {
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        childView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func setCenterConstraints(for childView: UIView, with parentView: UIView) {
        childView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        childView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        childView.translatesAutoresizingMaskIntoConstraints = false
    }
}
