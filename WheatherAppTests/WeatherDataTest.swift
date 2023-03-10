//
//  WeatherDataTest.swift
//  WheatherAppTests
//
//  Created by Mac on 06.03.2023.
//

import XCTest
@testable import WheatherApp

class WeatherDataTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func testCanParseWeather() throws {
        let json = """
                {
                   "weather": [
                     {
                       "id": 804,
                       "description": "overcast clouds",
                     }
                   ],
                   "main": {
                     "temp": 10.58,
                   },
                   "name": "Calgary"
                 }
                """
        let jsonData = json.data(using: .utf8)!
        let weatherData = try! JSONDecoder().decode(WeatherData.self, from: jsonData)
        
        XCTAssertEqual(10.58, weatherData.main.temp)
        XCTAssertEqual("Calgary", weatherData.name)
        XCTAssertEqual(804, weatherData.weather[0].id)
        XCTAssertEqual("overcast clouds", weatherData.weather[0].description)
    }
    
    func testCanParseWeatherWithEmptyCityName() throws {
        let json = """
                 {
                   "weather": [
                     {
                       "id": 804,
                       "description": "overcast clouds",
                     }
                   ],
                   "main": {
                     "temp": 10.58,
                   },
                   "name": ""
                 }
                """
        let jsonData = json.data(using: .utf8)!
        let weatherData = try! JSONDecoder().decode(WeatherData.self, from: jsonData)
        
        XCTAssertEqual("", weatherData.name)
    }
    
    func testCanParseWeatherViaJSONFile() throws {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json") else {
            fatalError("json not found")
        }
        
        print("\n\n\(pathString)\n\n")
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let weatherData = try! JSONDecoder().decode(WeatherData.self, from: jsonData)
        
        XCTAssertEqual(25.65, weatherData.main.temp)
        XCTAssertEqual("Paris", weatherData.name)
    }
    
}
