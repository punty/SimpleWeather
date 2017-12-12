//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 08/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct City: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case cityId = "id"
        case country
        case coordinate = "coord"
    }
    let cityId: Double
    let name: String
    let country: String
    let coordinate: Coordinate
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

struct Forecast: Codable {
    enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    let city: City
    let list: [WeatherForecast]
}

struct WeatherForecast: Codable {
    let dt: Double
    let main: MainInfo
    let weather: [WeatherInfo]
}

struct MainInfo: Codable {
    let temp: Double
    let humidity: Double
}

struct WeatherInfo: Codable {
    let weatherId: Double
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case description
        case icon
    }
}


