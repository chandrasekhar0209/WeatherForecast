//
//  FiveDayForecastModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

struct FiveDayForecastModel: Codable {
    var cod: String?
    var message: Int?
    var count: Int?
    var list: [TodayForecastModel]?
    var city: City?
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case count = "cnt"
        case list = "list"
        case city = "city"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Int.self, forKey: .message)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        list = try values.decodeIfPresent([TodayForecastModel].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
    }
}

struct City: Codable {
    var id: Int?
    var name: String?
    var coordinates: Coordinates?
    var country: String?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coordinates = "coordinates"
        case country = "country"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
    }
}
