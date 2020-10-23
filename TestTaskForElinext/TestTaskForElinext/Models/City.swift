//
//  City.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import Foundation
import UIKit

struct City: Codable {
    var name:String?
    var countryCode:String?
    var cityDescription:String?
    var currentTemperatureAndWeatherDescription:String?
    var temperatureAndWeatherRefreshDate:Date?
}
