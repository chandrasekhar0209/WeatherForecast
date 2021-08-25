//
//  UIImageView+Extensions.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 25/08/21.
//

import UIKit

extension UIImageView {
    static func loadImage(in imageView: UIImageView, with name: String) {
        if let iconUrl = try? ServiceDetails.fetch().iconUrl {
            let imageUrl = "\(iconUrl)\(name).png"
            if let url = URL(string: imageUrl) {
                DispatchQueue.global(qos: .background).async {
                    do {
                        let imageData = try Data.init(contentsOf: url)
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: imageData)
                        }
                    } catch  {}
                }
            }
        }
    }
}
