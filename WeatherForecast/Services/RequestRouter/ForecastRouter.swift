//
//  TodayForecastRouter.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import Foundation

enum ForecastRouter: ServiceRequestRouter {
    case todayForecast(_ latitude: Double, _ longitude: Double)
    case fiveDayForecast(_ latitude: Double, _ longitude: Double)
    var path: String {
        switch self {
        case .todayForecast:
            return "/data/2.5/weather"
        case .fiveDayForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var methodType: HTTPMethod {
        switch self {
        case .todayForecast, .fiveDayForecast:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "Application/json"]
    }
    
    var queryItems: QueryItems {
        switch self {
        case .todayForecast(let latitude, let longitude):
            return ["lat": latitude, "lon": longitude]
        case .fiveDayForecast(let latitude, let longitude):
            return ["lat": latitude, "lon": longitude]
        }
    }
    
    var body: Parameters? {
        switch self {
        case .todayForecast, .fiveDayForecast:
            return nil
        }
    }
}
