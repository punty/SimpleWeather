//
//  StubNetworkingService.swift
//  SimpleAppTests
//
//  Created by Francesco Puntillo on 12/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
@testable import SimpleWeather

final class StubNetworkingService: ServiceClientType {

    enum StubError: Error {
        case testError
    }

    let fails: Bool

    init(fails: Bool = false) {
        self.fails = fails
    }
    
    func get<T>(api: API, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        if fails {
            completion(Result<T>.failure(error: StubError.testError))
        } else {
            let stubData = api.stubResponse()
            let object = try! JSONDecoder().decode(T.self, from: stubData)
            completion(Result<T>.success(object))
        }
    }
    
    func data(api: API, completion: @escaping (Result<Data>) -> Void) {
        //TODO
    }

}
