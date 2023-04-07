//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation

// Структура в которой собираются данные из json данных которые поступили в ApiResponse
struct WeatherData {
    var name: String = "Название"
    var temperature: Double = 0.0
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0.0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    var conditionString: String {
        switch condition {
        case "clear": return "Ясно"
        case "partly-cloudy": return "Малооблачно"
        case "cloudy": return "Облачно с прояснениями"
        case "overcast": return "Пасмурно"
        case "drizzle": return "Морось"
        case "light-rain": return "Небольшой дождь"
        case "moderate-rain": return "Умеренно сильный дождь"
        case "heavy-rain": return "Сильный дождь"
        case "continuous-heavy-rain": return "Длительный сильный дождь"
        case "showers": return "Ливень"
        case "wet-snow": return "Дождь со снегом"
        case "light-snow": return "Небольшой снег"
        case "snow": return "Снег"
        case "snow-showers": return "Снегопад"
        case "hail": return "Град"
        case "thunderstorm": return "Гроза"
        case "thunderstorm-with-rain": return "Дождь с грозой"
        case "thunderstorm-with-hail": return "Гроза с градом"
        default: return "Загрузка"
        }
    }
    
    init?(apiResponse: ApiResponse) {
        temperature = apiResponse.fact.temp
        conditionCode = apiResponse.fact.icon
        url = apiResponse.info.url
        condition = apiResponse.fact.condition
        pressureMm = apiResponse.fact.pressureMm
        windSpeed = apiResponse.fact.windSpeed
        tempMin = apiResponse.forecasts.first!.parts.day.tempMin!
        tempMax = apiResponse.forecasts.first!.parts.day.tempMax!
    }
    
    init() {
        
    }
}


// Массив который содержит все города
var citiesArray = [WeatherData]()
