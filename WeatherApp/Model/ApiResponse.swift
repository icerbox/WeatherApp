//
//  ApiResponse.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import UIKit

struct ApiResponse: Codable {

    var info: Info
    var fact: Fact
    var forecasts: [Forecasts]

}

struct Info: Codable {
    var url: String
}

struct Fact: Codable {
    var temp: Int
    var icon: String
    var condition: String
    var windSpeed: Double
    var pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, icon, condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecasts: Codable {
    var parts: Parts
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













