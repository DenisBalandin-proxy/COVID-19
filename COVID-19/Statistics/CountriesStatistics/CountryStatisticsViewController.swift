//
//  CountryStatistics.swift
//  COVID-19
//
//  Created by Denis on 2023/04/08.
//

import UIKit

final class CountryStatisticsViewController: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let cellIdentifireForStatistics = "CellForCountries"
    
    // MARK: - Public Properties
    var viewModel: CountryStatisticsViewModelProtocol! {
        didSet {
            setupUI()
            labelCountry.text = viewModel.countryName
        }
    }
    
    //MARK: - Private Properties
    private var visualView = VisualEffect()
    private var blurView: UIVisualEffectView!
    
    private var labelCountry: UILabel!
    
    //MARK: - Life Cycle Methods
    override func prepareForReuse() {
      super.prepareForReuse()
        
        blurView.removeFromSuperview() //remove before reuse
        blurView = visualView.setBlurView()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        blurView = visualView.setBlurView()
        blurView.layer.cornerRadius = 30
        
        let countryLabel = UILabel(frame: .zero)
        countryLabel.textAlignment = .center
        countryLabel.numberOfLines = 4
        labelCountry = countryLabel
        
        TAMIC()
        addSubviews()
        setupConstraints()
    }
    
    private func TAMIC() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        labelCountry.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(blurView)
        blurView.contentView.addSubview(labelCountry)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        blurView.topAnchor.constraint(equalTo: topAnchor),
        blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
        blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        
        labelCountry.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
        labelCountry.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
        labelCountry.leadingAnchor.constraint(equalTo: blurView.leadingAnchor)
        ])
    }
}
