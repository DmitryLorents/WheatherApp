//
//  ParseJSON.swift
//  WheatherApp
//
//  Created by Mac on 03.03.2023.
//

import Foundation

let json = """
 {
   "weather": [{"id": 804,"description": "overcast clouds",}],
   "main": {"temp": 10.58,},
   "name": "Calgary"
 }
"""
struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
}
