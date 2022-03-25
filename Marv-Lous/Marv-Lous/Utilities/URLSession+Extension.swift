//
//  URLSession+Extension.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import Foundation

extension URLSession {
    
    enum CustomError: Error {
        case invalidResponse
        case invalidRequest
        case invalidUrl
        case invalidData
    }
    
    func makeRequest<Generic: Codable>(url: URL?,
                                       model: Generic.Type,
                                       headers: [String : String],
                                       completion: @escaping (Result<Generic, Error>) -> Void) {
        
        guard let endpointUrl = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: endpointUrl)
        callRequest(with: request, model: model, completion: completion)
        
    }
        
    func callRequest<Generic: Codable>(with request: URLRequest, model: Generic.Type, completion: @escaping((Result<Generic, Error>) -> Void)) {
        
        let apiTask = self.dataTask(with: request) { data, _, error in
            
            guard let safeData = data else {
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model, from: safeData)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        apiTask.resume()
    }
}
