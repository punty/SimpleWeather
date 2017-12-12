//
//  WeatherCellViewModel.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 09/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

final class WeatherCellViewModel {
    
    let descriptionString: String?
    let temperature: String?
    let date: String?
    
    init (model: WeatherForecast) {
        descriptionString = model.weather.first?.description
        temperature = "\(model.main.temp) ºC"
        date = DateUtils.format(date: model.dt, format: "HH:mm")
    }
}
