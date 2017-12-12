//
//  Sequence+Categorize.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 09/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation

extension Sequence {
    func categorize<U : Equatable, V>(key: (Iterator.Element) -> U, mapValue:(Iterator.Element) -> V) -> [SectionModel<U, V>] {
        var sections: [SectionModel<U, V>] = []
        for el in self {
            let key = key(el)
            if sections.last?.model == key {
                var last = sections.removeLast()
                last.items.append(mapValue(el))
                sections.append(last)
            } else {
                sections.append(SectionModel(model:key, items:[mapValue(el)]))
            }
        }
        return sections
    }
}
