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
    
    // MARK: Public Properties
    var viewModel: CountryStatisticsViewModelProtocol! {
        didSet {
            labelCountry.text = viewModel.countryName
        }
    }
    
    //MARK: - Private Properties
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        return blurredEffectView
    }()
    
    private lazy var labelCountry: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 4
        
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        blurView.layer.cornerRadius = 30
        
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
