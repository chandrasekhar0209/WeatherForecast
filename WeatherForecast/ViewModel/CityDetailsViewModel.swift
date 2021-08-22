//
//  CityDetailsViewModel.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

protocol CityDetailsProtocol {
    func fetchCityForecast<R: ServiceRequestRouter, C: Codable>(router: R, codable: C.Type, completion: @escaping (ServiceRequestResult<Codable?, Error?>) -> Void)
}

class CityDetailsViewModel {
    var serviceManager: ServiceManagerProtocol
    
    init(serviceManager: ServiceManagerProtocol = ServiceManager()) {
        self.serviceManager = serviceManager
    }
}

extension CityDetailsViewModel: CityDetailsProtocol {
    func fetchCityForecast<R, C>(router: R, codable: C.Type, completion: @escaping (ServiceRequestResult<Codable?, Error?>) -> Void) where R : ServiceRequestRouter, C : Decodable, C : Encodable {
        serviceManager.fetchCodable(router: router, codable: codable) { response in
            switch response {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
