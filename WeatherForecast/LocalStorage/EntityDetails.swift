//
//  EntityDetails.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import Foundation

enum EntityName: String {
    case bookmarks = "Bookmarks"
}

enum BookmarkEntityKeys: String {
    case cityName
    case latitude
    case longitude
}

enum ContainerName: String {
    case weatherForecast = "WeatherForecast"
}
