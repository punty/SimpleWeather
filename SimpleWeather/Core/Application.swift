//
//  Application.swift
//  SimpleApp
//
//  Created by Francesco Puntillo on 07/11/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

final class Application {
    lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        let viewModel: Attachable<WeatherViewModel> = .detached(WeatherViewModel.Dependencies(serviceClient: Application.serviceClient))
        let viewController = WeatherViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }()

    // MARK: - Services
    static let serviceClient: ServiceClientType = ServiceClient()
}
