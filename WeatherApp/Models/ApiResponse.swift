//
//  ApiResponse.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import UIKit

// Структура в которую приходят данные из json
struct ApiResponse: Codable {
    var info: Info
    var fact: Fact
    var forecasts: [Forecasts]
}

struct Info: Codable {
    var url: String
}

struct Fact: Codable {
    var temp: Double
    var feels_like: Int
    var icon: String
    var condition: String
    var windSpeed: Double
    var pressureMm: Int
    var humidity: Int
    var obs_time: Double
    var wind_dir: String
    
    enum CodingKeys: String, CodingKey {
        case temp, feels_like, icon, condition, humidity, obs_time, wind_dir
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecasts: Codable {
    var parts: Parts
    var rise_begin: String
    var set_end: String
}

struct Parts: Codable {
    var day: Day
}

struct Day: Codable {
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
