//
//  WeatherManager.swift
//  Clima
//
//  Created by Seedy on 29/07/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=432c9485fb7da1da3e92c8150cee05eb&units=metric"
    //a533afe6947bc3d0e31a454562a2b60c

    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let apiString = "\(url)&q=\(cityName)"
        perfromReq(urlString: apiString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let apiString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        perfromReq(urlString: apiString)
    }
    
    func perfromReq(urlString: String){
        // l
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url, completionHandler: handle(data:url:err:))
            let task = session.dataTask(with: url) { data, response, err in
                if err != nil{
                    print(err!)
                    return
                }
                if let safeData = data{
//                    let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData){
                        //self.
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(cityName: name, temperature: temp, conditionId: id)
            print(weather.conditionName)
//            print(decodedData.name)
            return weather
        }catch{
            delegate?.didFailWithError(err: error)
            return nil
        }
    }
    
    
}


protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(err: Error)
}
