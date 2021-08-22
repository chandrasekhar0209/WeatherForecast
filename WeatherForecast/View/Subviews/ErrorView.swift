//
//  ErrorView.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import UIKit

struct ErrorProperties {
    var imageName: String?
    var message: String?
    
    init(imageName: String? = nil, message: String? = nil) {
        self.imageName = imageName
        self.message = message
    }
}
class ErrorView: UIView {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    static let nibName = "ErrorView"
    
    func configureView(with properties: ErrorProperties) {
        errorImage.image =  UIImage(systemName: properties.imageName ?? "")
        errorMessage.text = properties.message
    }
}
