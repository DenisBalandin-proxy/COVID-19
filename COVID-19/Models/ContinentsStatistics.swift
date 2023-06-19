//
//  ContinentsStatistics.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import Foundation

struct Coronavirus: Decodable {
    let continent: String
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
}
