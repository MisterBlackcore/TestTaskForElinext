//
//  CustomTableViewCell.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/21/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    //MARK: - Flow Functions
    
    func fillInTheCell(item: City) {
        if let cityName = item.name {
            cityNameLabel.text = cityName
        }
        if let countryCode = item.countryCode {
            countryCodeLabel.text = countryCode
        }
    }
    
}
