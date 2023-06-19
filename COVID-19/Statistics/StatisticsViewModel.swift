//
//  StatisticsViewModelProtocol.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import Foundation

//MARK: - Statistics View Model Protocol
protocol StatisticsViewModelProtocol {
    var continent: Int { get }
    
    func setContinent(at indexPath: IndexPath)
    func fetchStatistics(completion: @escaping() -> Void)
    func fetchCountries(completion: @escaping() -> Void)
    func numberOfCellsInGeneralCollection() -> Int
    func numberOfCellsInCountriesCollection() -> Int
    func getGeneralStatisticsCellViewModel(at intexPath: IndexPath) -> GeneralStatisticsViewModelProtocol
    func getCountryStatisticsViewModel(at indexPath: IndexPath) -> CountryStatisticsViewModelProtocol
    func getContenentCellViewModel(at indexPath: IndexPath) -> ContinentViewModelProtocol
}
// MARK: - Statistics View Model
final class StatisticsViewModel: StatisticsViewModelProtocol {
    
    // MARK: - Public Properties
    var continent: Int = 0
    
    // MARK: - Private Properties
    private var covidStatistics: [Coronavirus] = []
    private var countries: [Countries] = []
    private var tappedSection = 0
    
    // MARK: - Public Methods
    func fetchStatistics(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchCOVIDStatistics(
            from: Link.continents.rawValue
        ) { [unowned self] coronavirus in
            switch coronavirus {
            case .success(let covid):
                self.covidStatistics = covid
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func fetchCountries(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchCountriesStatistics(
            from: Link.covidYesterday.rawValue
        ) { [unowned self] country in
            switch country {
            case .success(let covid):
                self.countries = covid
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }

    func numberOfCellsInGeneralCollection() -> Int {
        covidStatistics.count
    }
    
    func numberOfCellsInCountriesCollection() -> Int {
        countries.count
    }
    
    func getGeneralStatisticsCellViewModel(at intexPath: IndexPath) -> GeneralStatisticsViewModelProtocol {
        GeneralStatisticsViewModel(statistics: covidStatistics[continent], index: intexPath)
    }
    
    func getCountryStatisticsViewModel(at indexPath: IndexPath) -> CountryStatisticsViewModelProtocol {
        CountryStatisticsViewModel(country: (countries[indexPath.row]))
    }
    
    func setContinent(at indexPath: IndexPath) {
        continent = indexPath.row
    }
    
    func getContenentCellViewModel(at indexPath: IndexPath) -> ContinentViewModelProtocol {
        ContinentViewModel(statistics: covidStatistics[indexPath.row])
    }
}
                
