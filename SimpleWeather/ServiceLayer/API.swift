//
//  API.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

enum API {
    static let host = "api.openweathermap.org"
    static let imageHost = "openweathermap.org"
    static let APIKey = "017887b8d63f02125d64d58c45b93a18"
    
    case forecast(query: String)
    case image(image: String)
    
    private var path: String {
        switch self {
            case .forecast:
                return "/data/2.5/forecast/"
            case .image(let icon):
                return "/img/w/\(icon).png"
        }
    }
    
    private var host: String {
        switch self {
        case .forecast:
            return API.host
        case .image:
            return API.imageHost
        }
    }
    
    private var query: [String: String] {
        switch self {
            case .forecast(let query):
                return ["q":query,
                        "appid": API.APIKey,
                        "units": "metric"]
            case .image:
                return [:]
        }
    }
    
    func asURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host
        urlComponents.path = self.path
        urlComponents.queryItems = query.map {
            entry in
            return URLQueryItem(name: entry.key, value: entry.value)
        }
        guard let url = urlComponents.url else {fatalError("malformed url")}
        return URLRequest(url: url)
    }
}
