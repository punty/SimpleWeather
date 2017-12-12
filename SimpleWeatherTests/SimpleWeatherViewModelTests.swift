//
//  SimpleWeatherViewModelTests.swift
//  SimpleWeatherViewModelTests
//
//  Created by Francesco Puntillo on 08/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import XCTest
@testable import SimpleWeather

class SimpleWeatherViewModelTests: XCTestCase {
    
    private var itemsArray:[[SectionModel<String,WeatherCellViewModel>]] = [[]]
    private var cityArray:[String] = []
    private var enableArray:[Bool] = []
    private var errorsArray: [String] = []
    private var enableRowsArray:[Int] = []
    
    override func setUp() {
        super.setUp()
        itemsArray = [[]]
        cityArray = []
        enableArray = []
        errorsArray = []
        enableRowsArray = []
    }
    
    private func prepareBindings(setupExpectation: Bool = false) ->
        WeatherViewModel.Bindings {
            var itemsExpect: XCTestExpectation?
            if setupExpectation {
                itemsExpect = expectation(description: "items")
            }
            
            let update: ([SectionModel<String,WeatherCellViewModel>]) -> Void = { [weak self] (items: [SectionModel<String,WeatherCellViewModel>]) in
                self?.itemsArray.append(items)
                itemsExpect?.fulfill()
            }
            let updateCity: (String) -> Void = { [weak self] (cityInfo: String) in
                self?.cityArray.append(cityInfo)
            }
            let enableSearch: (Bool) -> Void = { [weak self] (enable: Bool) in
                self?.enableArray.append(enable)
            }
            let showError: (String) -> Void   = { [weak self] (error: String) in
                self?.errorsArray.append(error)
            }
            let enableRows: (Int) -> Void = { [weak self] (rows: Int) in
                self?.enableRowsArray.append(rows)
            }
            return WeatherViewModel.Bindings(updateCollectionView: update, showError: showError, enableSearch: enableSearch, enableRows: enableRows, updateCityInfo: updateCity)
    }
    
    
    
    func testLoadingWhenPressed() {
        let dependencies = WeatherViewModel.Dependencies(serviceClient: StubNetworkingService())
        let vm = WeatherViewModel(dependencies: dependencies, bindings: prepareBindings(setupExpectation: true))
        vm.updateText(text: "London")
        vm.buttonPressed()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(itemsArray[0].count == 0)
        XCTAssertTrue(itemsArray[1].count == 5)
    }
    
    func testDisableSearchButton() {
        let dependencies = WeatherViewModel.Dependencies(serviceClient: StubNetworkingService())
        let vm = WeatherViewModel(dependencies: dependencies, bindings: prepareBindings(setupExpectation: true))
        vm.updateText(text: "London")
        vm.buttonPressed()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(enableArray.count == 2)
        XCTAssert(enableArray[0] == false)
        XCTAssert(enableArray[1] == true)
    }
    
    //when start I should show 0 rows and no city information
    func testStartingViewModel() {
        let dependencies = WeatherViewModel.Dependencies(serviceClient: StubNetworkingService())
        _ = WeatherViewModel(dependencies: dependencies, bindings: prepareBindings())
        XCTAssertTrue(enableRowsArray[0] == 0)
        XCTAssertTrue(cityArray[0] == "")
        XCTAssertTrue(itemsArray[0].count == 0)
    }
    
}

