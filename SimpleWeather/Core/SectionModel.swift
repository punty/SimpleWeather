//
//  SectionModel.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 09/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

struct SectionModel<Section, Item> {
    var model: Section
    var items: [Item]
    
    init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}
