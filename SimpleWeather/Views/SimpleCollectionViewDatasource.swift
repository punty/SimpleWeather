//
//  SimpleCollectionViewDatasource.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 09/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import Foundation
import UIKit


final class SimpleCollectionViewDataSource<Cell: UICollectionViewCell ,Section, Item>: NSObject, UICollectionViewDataSource {
    
    var models: [SectionModel<Section, Item>]
    
    typealias ConfigureCell = (Cell, Item) -> Void
   
    init(configureCell: @escaping ConfigureCell) {
        self.models = []
        self.configureCell = configureCell
    }
    
    fileprivate let configureCell: ConfigureCell

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return models.indices.contains(collectionView.tag) ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models[collectionView.tag].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath)
        configureCell(cell as! Cell, models[collectionView.tag].items[indexPath.row])
        return cell
    }
}



