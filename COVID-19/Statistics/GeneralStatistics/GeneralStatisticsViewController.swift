//
//  GeneralStatistics.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import UIKit

final class GeneralStatisticsViewController: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let cellIdentifireForStatistics = "CellForStatistics"
    
    // MARK: Public Properties
    var viewModel: GeneralStatisticsViewModelProtocol! {
        didSet {
            setupUI()
            labelTitle.text = viewModel.generalStatistics.title
            labelValue.text = viewModel.generalStatistics.value
        }
    }
        
    // MARK: Private Properties
    private lazy var labelTitle = setupTitleLabel()
    private lazy var labelValue = setupValueLabel()
    
    private lazy var shadowView = UIView()
    
    // MARK: - Life Cycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCell()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        labelTitle = setupTitleLabel()
        labelValue = setupValueLabel()

        TAMIC()
        addSubviews()
        setupConstraints()
    }
    
    private func setupTitleLabel() -> UILabel {
        let labelTitle = UILabel()
        labelTitle.numberOfLines = 2
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        
        return labelTitle
    }
    
    private func setupValueLabel() -> UILabel {
        let valueLabel = UILabel()
        valueLabel.textAlignment = .center
        valueLabel.textColor = .gray
        
        return valueLabel
    }
        
    private func TAMIC() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(shadowView)
        addSubview(labelTitle)
        addSubview(labelValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelTitle.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            labelTitle.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),
            
            labelValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelValue.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
            
    private func setupCell() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10.0

        shadowView.layer.cornerRadius = 31.0
        shadowView.addVerticalGradientLayer()
        shadowView.layer.masksToBounds = true
    }
}
