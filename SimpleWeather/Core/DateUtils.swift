//
//  DateUtils.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 12/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct DateUtils {
    static let dateFormatter = DateFormatter()
    static func format(date: Double, format: String) -> String {
        let dateVal = Date(timeIntervalSince1970: date)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateVal)
    }
}
