//
//  WeatherViewModel.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 08/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

final class WeatherViewModel: ViewModel {
    
    struct Dependencies {
        let serviceClient: ServiceClientType
    }
    
    struct Bindings {
        let updateCollectionView: ( [SectionModel<String,WeatherCellViewModel>]) -> Void
        let showError: (String) -> Void
        let enableSearch: (Bool) -> Void
        let enableRows: (Int) -> Void
        let updateCityInfo: (String) -> Void
    }
    
    var dependencies: WeatherViewModel.Dependencies
    static let maxNumberOfRows = 6
    private var searchText: String = ""
    private let bindings: WeatherViewModel.Bindings
    
    init(dependencies: WeatherViewModel.Dependencies, bindings: WeatherViewModel.Bindings) {
        self.dependencies = dependencies
        self.bindings = bindings
        self.bindings.enableRows(0)
        self.bindings.updateCityInfo("")
    }
    
    
    static private func cityInfo(city: City) -> String {
        return "City: \(city.name.capitalized), Lat:\(city.coordinate.lat), Lon: \(city.coordinate.lon)"
    }
    
    func loadData(query: String) {
        bindings.enableSearch(false)
        bindings.updateCityInfo("")
        dependencies.serviceClient.get(api: API.forecast(query: query)) {(result: Result<Forecast>) in
            switch result {
            case .success(let forecast):
                var vms = forecast.list.categorize(key: {
                    return DateUtils.format(date: $0.dt, format: "EEEE \n dd/MM")
                }, mapValue: {
                    return WeatherCellViewModel(model: $0)
                })
                vms = Array(vms.dropLast())
                DispatchQueue.main.async { [weak self] in
                    self?.bindings.enableSearch(true)
                    self?.bindings.enableRows(vms.count)
                    self?.bindings.updateCollectionView(vms)
                     self?.bindings.updateCityInfo(WeatherViewModel.cityInfo(city: forecast.city))
                }
            case .failure:
                DispatchQueue.main.async { [weak self] in
                    self?.bindings.enableRows(0)
                    self?.bindings.enableSearch(true)
                    self?.bindings.updateCityInfo("")
                }
            }
        }
    }
    
    func buttonPressed() {
        loadData(query: self.searchText + ",gb")
    }
    
    func updateText(text: String) {
        self.searchText = text
    }
    
    
}
