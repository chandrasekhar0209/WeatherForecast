//
//  ServiceManager.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 23/08/21.
//

import Foundation

protocol ServiceManagerProtocol {
    func fetchResponse<R: ServiceRequestRouter>(router: R, completion: @escaping ((ServiceRequestResult<ResponseJson, Error?>) -> Void))
    func fetchCodable<R: ServiceRequestRouter, C: Codable>(router: R, codable: C.Type, completion: @escaping (((ServiceRequestResult<Codable?, Error?>)) -> Void))
}

class ServiceManager {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
}

extension ServiceManager: ServiceManagerProtocol {
    func fetchResponse<R>(router: R, completion: @escaping ((ServiceRequestResult<ResponseJson, Error?>) -> Void)) where R : ServiceRequestRouter {
        networkClient.request(router: router) { [weak self] response in
            switch response {
            case .success(let data):
                completion(.success(self?.parseDataToJson(data: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCodable<R, C>(router: R, codable: C.Type, completion: @escaping (((ServiceRequestResult<Codable?, Error?>)) -> Void)) where R : ServiceRequestRouter, C : Decodable, C : Encodable {
        networkClient.request(router: router) {[weak self] response in
            switch response {
            case .success(let data):
                completion(.success(self?.parseDataToModel(data: data, decodingType: codable)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension ServiceManager {
    func parseDataToJson(data: Data?) -> [String: Any]? {
        do {
            guard let reponseData = data, let json = try JSONSerialization.jsonObject(with: reponseData, options: []) as? [String: Any] else {
                return nil
            }
            
            return json
        } catch {
            return nil
        }
    }
    
    func parseDataToModel<C: Codable>(data: Data?, decodingType: C.Type) -> Codable? {
        guard let data = data else { return nil }
        
        do {
            let model = try JSONDecoder().decode(decodingType, from: data)
            return model
        } catch  {
            return nil
        }
    }
}

enum ServiceRequestResult<S, E> {
    case success(S)
    case failure(E)
}

public typealias ResponseJson = [String: Any]?
