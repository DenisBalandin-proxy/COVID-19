//
//  NetworkManager.swift
//  COVID-19
//
//  Created by Denis on 2023/02/06.
//

import Alamofire

// MARK: - Enums
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case covidYesterday = "link1"
    case continents = "link2"
}

// MARK: - Network Manager
final class NetworkManager {
    
    //MARK: Static Properties
    static let shared = NetworkManager()
    
    //MARK: Private Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchCOVIDStatistics(
        from url: String,
        completion: @escaping(Result<[Coronavirus], AFError>) -> Void) {
            AF.request(url)
                .validate()
                .responseDecodable(of: [Coronavirus].self) { dataResponse in
                    switch dataResponse.result {
                    case .success(let statistics):
                        completion(.success(statistics))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func fetchCountriesStatistics(
        from url: String,
        completion: @escaping(Result<[Countries], AFError>) -> Void) {
            AF.request(url)
                .validate()
                .responseDecodable(of: [Countries].self) { dataResponse in
                    switch dataResponse.result {
                    case .success(let statistics):
                        completion(.success(statistics))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
}
