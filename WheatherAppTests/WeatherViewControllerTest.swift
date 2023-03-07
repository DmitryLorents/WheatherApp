//
//  WeatherViewControllerTest.swift
//  WheatherAppTests
//
//  Created by Mac on 07.03.2023.
//

import XCTest
@testable import WheatherApp

class WeatherViewControllerTest: XCTestCase {
    
    var viewController: WeatherViewController!

    override func setUpWithError() throws {
        viewController = WeatherViewController()
        viewController.loadViewIfNeeded()
    }
    
    func testCanGetWeatherAndPopulateView() {
        let weatherModel = WeatherModel(conditionId: 1, cityName: "Tokyo", temperature: 20)
        let mockWeatherService = WeatherServiceMock(delegate: viewController, weatherModel: weatherModel, error: nil)
        viewController.weatherService = mockWeatherService
        
        mockWeatherService.fetchWeather(cityName: "Tokyo")
        
        XCTAssertEqual("Tokyo", viewController.cityLabel.text)
        XCTAssertEqual("20°C", viewController.temperatureLabel.attributedText?.string)
    }
    
    func testCanHandleGeneralErrors() {
        let error = ServiceError.general(reason: "Internet down")
        let mockWeatherService = WeatherServiceMock(delegate: viewController, weatherModel: nil, error: error)
        viewController.weatherService = mockWeatherService
        mockWeatherService.fetchWeather(cityName: "Tokyo")
        XCTAssertEqual("Internet down", viewController.errorMessage!)
    }
    
    func testNetworkErrors() {
        let statusCode = 404
        let error = ServiceError.network(statusCode: statusCode)
        let mock = WeatherServiceMock(delegate: viewController, weatherModel: nil, error: error)
        viewController.weatherService = mock
        mock.fetchWeather(cityName: "Brisben")
        XCTAssertEqual("Networking error. Status code: \(statusCode)", viewController.errorMessage!)
    }

    func testParsingErrors() {
        
        let error = ServiceError.parsing
        let mock = WeatherServiceMock(delegate: viewController, weatherModel: nil, error: error)
        viewController.weatherService = mock
        mock.fetchWeather(cityName: "")
        XCTAssertEqual("JSON weather data could not be parsed.", viewController.errorMessage!)
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
