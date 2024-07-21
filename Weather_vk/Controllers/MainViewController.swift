//
//  ViewController.swift
//  Weather_vk
//
//  Created by ZhZinekenov on 21.07.2024.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var currentWeatherView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupInitialWeatherView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupInitialWeatherView() {
        let randomWeather = WeatherCondition.allCases.randomElement()!
        displayWeatherView(for: randomWeather)
    }
    
    private func displayWeatherView(for condition: WeatherCondition) {
        currentWeatherView?.removeFromSuperview()
        
        let newWeatherView: SKView
        switch condition {
        case .clear:
            newWeatherView = ClearWeatherView(frame: view.bounds)
        case .rain:
            newWeatherView = RainWeatherView(frame: view.bounds)
        case .thunderstorm:
            newWeatherView = ThunderstormWeatherView(frame: view.bounds)
        case .fog:
            newWeatherView = FogWeatherView(frame: view.bounds)
        }
        
        newWeatherView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newWeatherView)
        currentWeatherView = newWeatherView
        
        NSLayoutConstraint.activate([
            newWeatherView.topAnchor.constraint(equalTo: view.topAnchor),
            newWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newWeatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherCondition.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        let weather = WeatherCondition.allCases[indexPath.item]
        cell.configure(with: weather)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWeather = WeatherCondition.allCases[indexPath.item]
        displayWeatherView(for: selectedWeather)
    }
}

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with condition: WeatherCondition) {
        titleLabel.text = condition.localizedName
    }
}


