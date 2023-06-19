//
//  ContinentsViewModel.swift
//  COVID-19
//
//  Created by Denis on 2023/05/21.
//

import Foundation

// MARK: - Continent View Model Protocol
protocol ContinentViewModelProtocol {
    var continent: String { get }
    init(statistics: Coronavirus)
}

// MARK: - Continent View Model
final class ContinentViewModel: ContinentViewModelProtocol {
    
    // MARK: Public Properties
    var continent: String {
        covid.continent
    }
    
    // MARK: Private Properties
    private var covid: Coronavirus
    
    // MARK: Initializers
    init(statistics: Coronavirus) {
        covid = statistics
    }
}
