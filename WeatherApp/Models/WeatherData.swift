//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation

// Массив который содержит все города
var citiesArray = [WeatherData]()

// Структура в которой собираются данные из json данных которые поступили в ApiResponse
struct WeatherData {
    var name = "Название"
    var temperature = 0.0
    // Вводим переменную temperatureString чтобы убрать .0 из показателя температуры
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var feelsLike = 0
    // Вводим переменную temperatureString чтобы убрать .0 из показателя температуры
    var conditionCode = ""
    var url = ""
    var condition = ""
    var pressureMm = 0
    var windSpeed = 0.0
    // Вводим переменную windString чтобы убрать .0 из показателя скорости ветра
    var windString: String {
        return String(format: "%.0f", windSpeed)
    }
    var humidity = 0
    var tempMin = 0
    var tempMax = 0
    var obs_time = 0.0
    var rise_begin = ""
    var set_end = ""
    var wind_dir = ""
    
    var conditionString: String {
        switch condition {
        case "clear": return "Ясно"
        case "partly-cloudy": return "Малооблачно"
        case "cloudy": return "Облачно с прояснениями"
        case "overcast": return "Пасмурно"
        case "drizzle": return "Морось"
        case "light-rain": return "Небольшой дождь"
        case "rain": return "Дождь"
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
    
    var windDirectionString: String {
        switch wind_dir {
        case "nw": return "с/з"
        case "n": return "с"
        case "ne": return "с/в"
        case "e": return "в"
        case "se": return "ю/в"
        case "s": return "ю"
        case "sw": return "ю/з"
        case "w": return "з"
        default: return "штиль"
        }
    }
    
    init?(apiResponse: ApiResponse) {
        temperature = apiResponse.fact.temp
        feelsLike = apiResponse.fact.feels_like
        conditionCode = apiResponse.fact.icon
        url = apiResponse.info.url
        condition = apiResponse.fact.condition
        pressureMm = apiResponse.fact.pressureMm
        windSpeed = apiResponse.fact.windSpeed
        humidity = apiResponse.fact.humidity
        obs_time = apiResponse.fact.obs_time
        tempMin = apiResponse.forecasts.first!.parts.day.tempMin!
        tempMax = apiResponse.forecasts.first!.parts.day.tempMax!
        rise_begin = apiResponse.forecasts.first!.rise_begin
        set_end = apiResponse.forecasts.first!.set_end
        wind_dir = apiResponse.fact.wind_dir
    }
    
    init() {
        
    }
}
