//
//  WeatherModel.swift
//  Clima
//
//  Created by Seedy on 05/08/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel{
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId{
            case 200...232:
                return "cloud.bolt"
            case 801...804:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            default:
                return "cloud"
        }

    }
    
}
