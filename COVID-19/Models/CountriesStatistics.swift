//
//  CountriesStatistics.swift
//  COVID-19
//
//  Created by Denis on 2023/06/19.
//

import Foundation

struct Countries: Decodable {
    let country: String
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
}
