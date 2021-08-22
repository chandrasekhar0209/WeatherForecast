//
//  ServiceRequestRouter.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 22/08/21.
//

import Foundation

protocol ServiceRequestRouter {
    var baseUrl: String { get }
    var path: String { get }
    var fullUrl: String { get }
    var methodType: HTTPMethod { get }
    var body: Parameters? { get }
    var headers: HTTPHeaders { get }
    var queryItems: QueryItems { get }
}

extension ServiceRequestRouter {
    public func asURLRequest() throws -> URLRequest {
        let url = try asURL()
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = methodType.rawValue

        #if DEBUG
            urlRequest.timeoutInterval = 20
        #else
            urlRequest.timeoutInterval = 30
        #endif

        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData

        headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = body, let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            urlRequest.httpBody = httpBody
        }

        return urlRequest as URLRequest
    }
    
    public func asURL() throws -> URL {
        var urlComponents = URLComponents(string:fullUrl)
        queryItems.forEach { (key: String, value: Any) in
            urlComponents?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        }
        if let value = try? ServiceDetails.fetch().appId {
            urlComponents?.queryItems?.append(URLQueryItem(name: "appid", value: value))
        }

        return (urlComponents?.url)!
    }
}

extension ServiceRequestRouter {
    var baseUrl: String {
        if let value = try? ServiceDetails.fetch().baseUrl {
            return value
        } else {
            return ""
        }
    }
    
    var fullUrl: String {
        return baseUrl + path
    }

    var body: Parameters? {
        return Parameters()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
}

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias QueryItems = [String: Any]
