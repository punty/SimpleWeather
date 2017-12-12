//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 08/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var headers: [UILabel]!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet var collectionViews: [UICollectionView]!
    
    private var viewModel: Attachable<WeatherViewModel>
    private let datasource: SimpleCollectionViewDataSource<WeatherCollectionViewCell,String,WeatherCellViewModel>
    
    init (viewModel: Attachable<WeatherViewModel>) {
        self.viewModel = viewModel
        datasource = SimpleCollectionViewDataSource(configureCell: { cell, viewModel in
                cell.descriptionLabel.text = viewModel.descriptionString
                cell.temperatureLabel.text = viewModel.temperature
                cell.timeLabel.text = viewModel.date
        })
        super.init(nibName: nil, bundle: nil)
        self.title = "Weather"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func registerViews(collectionView: UICollectionView) {
        collectionView.register(UINib.init(nibName: WeatherCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: WeatherCollectionViewCell.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViews.forEach { cv in
            registerViews(collectionView: cv)
            cv.dataSource = self.datasource
        }
        
        let update = { [weak self] (items: [SectionModel<String,WeatherCellViewModel>]) in
            self?.mainStackView.isHidden = false
            self?.datasource.models = items
            self?.collectionViews.forEach { cv in
                cv.reloadData()
            }
            
            self?.headers.forEach { label in
                label.text = items.indices.contains(label.tag) ? items[label.tag].model : ""
            }
        }
        
        let updateCity: (String) -> Void = { [weak self] (cityInfo: String) in
            self?.cityLabel.text = cityInfo
        }
        
        let enableSearch: (Bool) -> Void = { [weak self] (enable: Bool) in
            self?.searchButton.isEnabled = enable
        }
        
        
        let showError: (String) -> Void   = { [weak self] (error: String) in
            self?.mainStackView.isHidden = true
            //here it's possible to show an error
        }
        
        let enableRows: (Int) -> Void = { [weak self] (rows: Int) in
            for idx in 0 ..< WeatherViewModel.maxNumberOfRows {
                self?.collectionViews[idx].isHidden = !(0 ..< rows ~= idx)
                self?.headers[idx].isHidden = !(0 ..< rows ~= idx)
            }
        }
        viewModel.bind(WeatherViewModel.Bindings(updateCollectionView: update, showError: showError, enableSearch: enableSearch, enableRows: enableRows, updateCityInfo: updateCity))
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        viewModel.attached?.buttonPressed()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        viewModel.attached?.updateText(text: sender.text ?? "")
    }
    
    
}

