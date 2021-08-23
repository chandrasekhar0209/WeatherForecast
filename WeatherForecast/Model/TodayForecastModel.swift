//
//  TodayForecastModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

struct TodayForecastModel: Codable {
    var coordinates: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var clouds: Clouds?
    var rainVolume: RainVolume?
    var snowVolume: SnowVolume?
    var date: Int?
    var system: System?
    var timezone: Int?
    var id: Int?
    var cityName: String?
    var cod: Int?
    var dateText: String?

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case clouds = "clouds"
        case rainVolume = "rain"
        case snowVolume = "snow"
        case date = "dt"
        case system = "sys"
        case timezone = "timezone"
        case id = "id"
        case cityName = "name"
        case cod = "cod"
        case dateText = "dt_txt"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        pop = try values.decodeIfPresent(Double.self, forKey: .pop)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        rainVolume = try values.decodeIfPresent(RainVolume.self, forKey: .rainVolume)
        snowVolume = try values.decodeIfPresent(SnowVolume.self, forKey: .snowVolume)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        system = try values.decodeIfPresent(System.self, forKey: .system)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
        dateText = try values.decodeIfPresent(String.self, forKey: .dateText)
    }
}

struct Coordinates: Codable {
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
    }
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
}

struct Main: Codable {
    var temperature: Double?
    var feelsLike: Double?
    var minTemperature: Double?
    var maxTemperature: Double?
    var pressure: Int?
    var seaLevel: Int?
    var groundLevel: Int?
    var humidity: Int?
    var tempKF: Double?

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity = "humidity"
        case tempKF = "temp_kf"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
        feelsLike = try values.decodeIfPresent(Double.self, forKey: .feelsLike)
        minTemperature = try values.decodeIfPresent(Double.self, forKey: .minTemperature)
        maxTemperature = try values.decodeIfPresent(Double.self, forKey: .maxTemperature)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        seaLevel = try values.decodeIfPresent(Int.self, forKey: .seaLevel)
        groundLevel = try values.decodeIfPresent(Int.self, forKey: .groundLevel)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        tempKF = try values.decodeIfPresent(Double.self, forKey: .tempKF)
    }
}

struct Wind: Codable {
    var speed: Double?
    var degree: Int?
    var gust: Double?

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case degree = "deg"
        case gust = "gust"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        degree = try values.decodeIfPresent(Int.self, forKey: .degree)
        gust = try values.decodeIfPresent(Double.self, forKey: .gust)
    }
}

struct Clouds: Codable {
    var cloudiness: Int?
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cloudiness = try values.decodeIfPresent(Int.self, forKey: .cloudiness)
    }
}

struct RainVolume: Codable {
    var lastOneHour: Double?
    var lastthreeHour: Double?

    enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
        case lastthreeHour = "3h"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastOneHour = try values.decodeIfPresent(Double.self, forKey: .lastOneHour)
        lastthreeHour = try values.decodeIfPresent(Double.self, forKey: .lastthreeHour)
    }
}

struct SnowVolume: Codable {
    var lastOneHour: Double?
    var lastthreeHour: Double?

    enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
        case lastthreeHour = "3h"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastOneHour = try values.decodeIfPresent(Double.self, forKey: .lastOneHour)
        lastthreeHour = try values.decodeIfPresent(Double.self, forKey: .lastthreeHour)
    }
}

struct System: Codable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    var partOfTheDay: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case message = "message"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case partOfTheDay = "pod"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        message = try values.decodeIfPresent(Double.self, forKey: .message)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        partOfTheDay = try values.decodeIfPresent(String.self, forKey: .partOfTheDay)
    }
}
