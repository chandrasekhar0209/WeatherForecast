//
//  NetworkClient.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

protocol NetworkClientProtocol {
    func request<R: ServiceRequestRouter>(router: R, completion: @escaping ((ServiceRequestResult<Data?, Error?>) -> Void))
}

struct NetworkClient {
    private let defaultSession = URLSession(configuration: .default)
}

extension NetworkClient: NetworkClientProtocol {
    func request<R>(router: R, completion: @escaping ((ServiceRequestResult<Data?, Error?>) -> Void)) where R : ServiceRequestRouter {
        do {
            try defaultSession.dataTask(with: router.asURLRequest(), completionHandler: { data, response, error in
                guard let responseData = data else {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(responseData))
            }).resume()
        } catch  {
            completion(.failure(error))
        }
    }
}
