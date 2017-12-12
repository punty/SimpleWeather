//
//  SimpleNetworking.swift
//  SimpleConverter
//
//  Created by Francesco Puntillo on 09/11/2016.
//  Copyright © 2016 Francesco Puntillo. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case data
    case network
}

protocol ServiceClientType {
    func get<T: Codable>(api: API, completion: @escaping (Result<T>) -> Void)
    func data(api: API, completion: @escaping (Result<Data>) -> Void)
   
}

final class ServiceClient: ServiceClientType {
    
    
    func data(api: API, completion: @escaping (Result<Data>) -> Void) {
        let task = URLSession.shared.dataTask(with: api.asURLRequest()) {
            data, response, error in
            if let dataUnwrap = data {
                completion(Result<Data>.success(dataUnwrap))
            } else {
                completion(Result<Data>.failure(error: ServiceError.network))
            }
        }
        task.resume()
    }
    
    func get<T: Codable>(api: API, completion: @escaping (Result<T>) -> Void) {
        let task = URLSession.shared.dataTask(with: api.asURLRequest()) {
            data, response, error in
            if let dataUnwrap = data {
                do {
                    let obj = try JSONDecoder().decode(T.self, from: dataUnwrap)
                    completion(Result<T>.success(obj))
                } catch {
                    completion(Result<T>.failure(error: ServiceError.data))
                }
            } else {
                completion(Result<T>.failure(error: ServiceError.network))
            }
        }
        task.resume()
    }
}
