//
//  WeatherService.swift
//  WheatherApp
//
//  Created by Mac on 02.03.2023.
//

import Foundation
import CoreLocation

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_weatherService: WeatherService, _ weather: WeatherModel)
}

struct WeatherService {
    weak var delegate: WeatherServiceDelegate?
    
    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 700, cityName: cityName, temperature: -10)
        delegate?.didFetchWeather(_weatherService: self, weatherModel)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let weatherModel = WeatherModel(conditionId: 800, cityName: "Paris", temperature: 25)
        delegate?.didFetchWeather(_weatherService: self, weatherModel)
    }
}
