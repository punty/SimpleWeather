//
//  WeatherCollectionViewCell.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 10/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    static let name = "WeatherCollectionViewCell"
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
