//
//  CountryStatisticsViewModelProtocol.swift
//  COVID-19
//
//  Created by Denis on 2023/04/08.
//

import Foundation

// MARK: - Country Statistics View Model Protocol
protocol CountryStatisticsViewModelProtocol {
    var countryName: String { get }
    var newConfirmed: Int { get }
    var newDeath: Int { get }
    
    init(country: Countries)
}

// MARK: - Country Statistics View Model
final class CountryStatisticsViewModel: CountryStatisticsViewModelProtocol {
    
    //MARK: - Public Properties
    var countryName: String {
        country.country
    }
    
    var newConfirmed: Int {
        country.todayCases
    }
    
    var newDeath: Int {
        country.todayDeaths
    }
    
    // MARK: - Private Properties
    private let country: Countries
    
    // MARK: - Initializers
    required init(country: Countries) {
        self.country = country
    }
}
