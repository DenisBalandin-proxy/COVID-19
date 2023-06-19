//
//  GeneralStatisticsViewModel.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import Foundation

// MARK: - General Statistics View Model Protocol
protocol GeneralStatisticsViewModelProtocol {
    var generalStatistics: (title: String, value: String) { get }
    
    init(statistics: Coronavirus, index: IndexPath)
}

// MARK: - General Statistics View Model
final class GeneralStatisticsViewModel: GeneralStatisticsViewModelProtocol {
    
    // MARK: - Public Properties
    var generalStatistics: (title: String, value: String) {
        switch index.row {
        case 0:
            return (title: "New Confirmed", value: String(statistics.todayCases))
        case 1:
            return (title: "Total Confirmed", value: String(statistics.cases))
        case 2:
            return (title: "New Death", value: String(statistics.todayDeaths))
        case 3:
            return (title: "Total Death", value: String(statistics.deaths))
        default:
            return (title: "Total Recovered", value: String(statistics.recovered))
        }
    }
    
    // MARK: Private Properties
    private let statistics: Coronavirus
    private let index: IndexPath
    
    // MARK: - Initializers
    required init(statistics: Coronavirus, index: IndexPath) {
        self.statistics = statistics
        self.index = index
    }
}
