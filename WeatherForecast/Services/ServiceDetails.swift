//
//  ServiceDetails.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

struct ServiceDetails: Codable {
    var baseUrl: String
    var appId: String
    var iconUrl: String

    static func fetch() throws -> Self {
        let plistName = "Info"
        guard let plistObj = PropertyListDecoder.fetch(type: ServiceDetails.self, name: plistName) else {
            fatalError("Could not find plist file = \(plistName)") }
        return plistObj
    }
}

extension PropertyListDecoder {
    static func fetch<T: Codable>(type: T.Type, name: String, from plist: String = "plist") -> T? {
    
        if let url = Bundle.main.url(forResource: name, withExtension:plist) {
            do {
                let data = try Data(contentsOf: url)
                let result = try PropertyListDecoder().decode(type.self, from: data)
                return result
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
