//
//  URLSession+Extension.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/16.
//

import Foundation

typealias SearchComicResult = (Result<ComicsModel, CustomError>) -> Void

protocol SearchComicRepositoryType: AnyObject {
    func fetchSearchResults(completion: @escaping(SearchComicResult))
}

class SearchComicRepository: SearchComicRepositoryType {
    
    func fetchSearchResults(completion: @escaping(SearchComicResult)) {
        makeRequest(url: buildURL(), model: ComicsModel.self, completion: completion)
    }
    
    private func buildURL() -> URL? {
        
        let timeStamp = Date().timeIntervalSince1970
        
        let hashedString = "\(timeStamp)\(Constants.privateAPIKey)\(Constants.publicAPIKey)"
        
        let queries = "format=comic&orderBy=-modified&limit=25"
        
        let urlString = String(format: "https://gateway.marvel.com:443/v1/public/comics?%@&apikey=%@&ts=%@&hash=%@",
                               queries,
                               Constants.publicAPIKey,
                               String(timeStamp),
                               hashedString.md5)
        
        return (URL(string: urlString))
    }
    
    private func makeRequest<Generic: Codable>(url: URL?,
                                               model: Generic.Type,
                                               completion: @escaping((Result<Generic, CustomError>) -> Void)) {
        
        guard let endpointUrl = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: endpointUrl)
        callRequest(with: request, model: model, completion: completion)
        
    }
        
    private func callRequest<Generic: Codable>(with request: URLRequest, model: Generic.Type, completion: @escaping(Result<Generic, CustomError>) -> Void) {
        
        let apiTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let safeData = data else {
                
                if error != nil {
                    DispatchQueue.main.async { completion(.failure(CustomError.invalidData)) }
                } else {
                    DispatchQueue.main.async { completion(.failure(CustomError.internalError)) }
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model, from: safeData)
                
                DispatchQueue.main.async {completion(.success(result))}
            } catch {
                DispatchQueue.main.async {completion(.failure(CustomError.parsingError))}
            }
            
        }
        apiTask.resume()
    }
}
