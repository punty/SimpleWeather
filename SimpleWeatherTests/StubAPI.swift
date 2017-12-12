//
//  StubAPI.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
@testable import SimpleWeather

extension API {
    func stubResponse() -> Data {
        let bundle = Bundle(for: SimpleWeatherViewModelTests.self)
        switch self {
        case .forecast:
            let fileUrl = bundle.url(forResource: "ForecastResponse", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            return data
        case .image:
            return Data()
        }
    }
}
