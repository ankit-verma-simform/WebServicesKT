//
//  APIManager.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

final class APIManager: NetworkManager {
    func request<T: Codable>(_ requestType: RequestType,
                             body: Codable? = nil,
                             completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        var urlRequest = URLRequest(url: requestType.url)
        urlRequest.httpMethod = requestType.method.rawValue
        
        if let headers = requestType.headers {
            for (headerField, headerValue) in headers {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        if requestType.method != .get && requestType.method != .delete {
            guard let body else {
                completionHandler(.failure(.emptyBody()))
                return
            }
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                completionHandler(.failure(.serializationError("Can't parse request body")))
                return
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error {
                completionHandler(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data, let httpResponse = urlResponse as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse()))
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                completionHandler(.failure(.notOKResponse("Server responded with status code: \(httpResponse.statusCode)")))
                return
            }
            
            do {
                let respData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(respData))

            } catch {
                completionHandler(.failure(.deserializationError("Can't convert data into type \(T.self)")))
                return
            }
        }.resume()
    }
    
    static let shared = APIManager()
    private init() {}
}
