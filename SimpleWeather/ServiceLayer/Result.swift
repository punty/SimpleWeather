//
//  Result.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 11/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(error: Error)
    
    var value: T? {
        switch self {
        case .success(let val):
            return val
        case .failure:
            return nil
        }
    }
}
