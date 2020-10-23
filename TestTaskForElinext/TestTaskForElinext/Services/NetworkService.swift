//
//  NetworkService.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private init () {}
    
    //MARK: - Flow Functions
    
    func getCurrentTemperatureAndWeatherInfoFromCityName(city: City,completion: @escaping (City) -> Void) {
        guard let cityName = city.name else {
            return
        }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=eba47effea88b18d5b67eae531209447") else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    var cityToReturn = city
                    cityToReturn.currentTemperatureAndWeatherDescription = JSONParsingService.shared.parsingWeatherData(json: json)
                    completion(cityToReturn)
                }
            }
        }.resume()
    }
    
    func getCurrentTemperatureAndWeatherInfoFromGeocoords(latitude: String, longtitude: String,completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=eba47effea88b18d5b67eae531209447") else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    let textToReturn = JSONParsingService.shared.parsingWeatherData(json: json)
                    completion(textToReturn)
                }
            }
        }.resume()
    }
    
}
