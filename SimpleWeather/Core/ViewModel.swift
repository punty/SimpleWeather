//
//  ViewModel.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 08/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

// MARK: - ViewModel
protocol ViewModel {
    associatedtype Dependencies
    associatedtype Bindings
    var dependencies: Dependencies {get set}
    init(dependencies: Dependencies, bindings: Bindings)
}

// MARK: - Attachable
enum Attachable<VM: ViewModel> {

    case detached(VM.Dependencies)
    case attached(VM)
    
    var attached: VM? {
        switch self {
        case .attached(let vm):
            return vm
        case .detached:
            return nil
        }
    }

    mutating func bind(_ bindings: VM.Bindings) {
        switch self {
        case .attached:
            break
        case .detached(let dependencies):
            let vm = VM.init(dependencies: dependencies, bindings: bindings)
            self = .attached(vm)
        }
    }
}
