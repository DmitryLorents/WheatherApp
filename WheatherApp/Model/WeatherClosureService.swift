//
//  WeatherClosureService.swift
//  WheatherApp
//
//  Created by Mac on 02.03.2023.
//

import Foundation

struct WeatherClosureService {
    var receiveWeatherHandler: ((WeatherModel) -> Void)?
    
    func fetchWeather(cityName: String) {
        guard let receiveWeatherHandler = receiveWeatherHandler else {return}
        let weatherModel = WeatherModel(conditionId: 600, cityName: cityName, temperature: -10)
        receiveWeatherHandler(weatherModel)
    }
}
