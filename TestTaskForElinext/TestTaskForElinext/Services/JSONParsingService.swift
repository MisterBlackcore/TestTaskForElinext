//
//  JSONParsingService.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import Foundation

class JSONParsingService {
    
    private let citiesDictionary = [
             ["city":"Riga", "country_code":"LV", "description":"столица Латвии и самый крупной город стран Балтии с численностью населения 627487 человек."],
             ["city":"Leipzig", "country_code":"DE", "description":"город в Германии, расположенный на западе федеральной земли Саксония. По численности населения (более 595000 человек) Лейпциг является крупнейшим городом Скасонии и восьмым - в Германии."],
             ["city":"Brno", "country_code":"CZ", "description":"статутный город в Чешской Республике в историческом регионе Моравия, близ слияния рек Свитавы и Свратки. Административный центр Южноморавского края и районов Брно-город и Брно-пригород."],
             ["city":"Tartu", "country_code":"EE", "description":"город на реке Эмайыги, второй по численности населения после Таллина город Эстонии, административный центр узла Тартумаа."],
             ["city":"Druskininkai", "country_code":"LT", "description":"курортный город на юге Литвы, административный центр Друскининкайского самоуправления в Алитусском уезде. Современный город в шутку называют «чемпионом Литвы по привлечению иностранных инвестиций»."],
             ["city":"Wroclaw", "country_code":"PL", "description":"один из самых крупных (четвёртый по населению в Польше после Варшавы, Кракова и Лодзи) и самых старых городов Польши, расположенный на обоих берегах среднего течения Одры, на Силезской низменности."],
             ["city":"Odessa", "country_code":"UA", "description":"город в Северном Причерноморье на юге Украины. Административный центр Одесской области и Одесского района. Главная военно-морская база Военно-морских сил Украины. Город-герой."],
             ["city":"Budapest", "country_code":"HU", "description":"столица Венгрии, образованная в 1873 году в результате слияния трёх городов на берегах Дуная: Пешта, Буды и Обуды. Крупнейший город страны и десятый по величине в Европейском союзе (около 1,75 млн жителей на 2019 год)."],
             ["city":"Brest", "country_code":"BY", "description":"город на юго-западе Белоруссии, административный центр Брестской области и Брестского района. Расположен в юго-западной части области, при впадении реки Мухавец в Западный Буг, у государственной границы с Польшей."]
     ]
    
    var citiesJson:Any?
    
    static let shared = JSONParsingService()
    private init () {
        citiesJson = createJSON()
    }
    
    //MARK: - Flow Functions
    
    private func createJSON() -> Any? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: citiesDictionary, options: .prettyPrinted) {
            let citiesJson = try? JSONSerialization.jsonObject(with: jsonData)
            return citiesJson
        } else {
            return nil
        }
    }
    
    func parsingCitiesDataFromJson() -> [City] {
        var citiesArray:[City] = []
        if let citiesDictionary = citiesJson as? [[String:Any]] {
            for cityDictionary in citiesDictionary {
                var cityItem = City()
                if let name = cityDictionary["city"] as? String {
                    cityItem.name = name
                }
                if let countryCode = cityDictionary["country_code"] as? String {
                    cityItem.countryCode = countryCode
                }
                if let description = cityDictionary["description"] as? String {
                    cityItem.cityDescription = description
                }
                citiesArray.append(cityItem)
            }
        }
        return citiesArray
    }

    func parsingWeatherData(json: [String:Any]) -> String {
        var temperatureNow = ""
        var weatherNow = ""
        if let temperatureInfo = json["main"] as? [String:Any] {
            if let currentTemperature = temperatureInfo["temp"] as? Double {
                temperatureNow = String(currentTemperature)
            }
        }
        if let weathers = json["weather"] as? [[String:Any]] {
            for weaather in weathers {
                if let weatherDescription  = weaather["description"] as? String {
                    weatherNow = weatherDescription
                }
            }
        }
        return returnWeatherDescription(temperature: temperatureNow, weather: weatherNow)
    }
    
    private func returnWeatherDescription(temperature: String, weather: String) -> String{
        return "The current temperature is \(temperature) and it is \(weather)."
    }
    
}
