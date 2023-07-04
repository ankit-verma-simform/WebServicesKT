//
//  NetworkManager.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

protocol NetworkManager {
    func request<T: Codable>(_ requestType: RequestType,
                             body: Codable?,
                             completionHandler: @escaping (Swift.Result<T, NetworkError>) -> Void)
}
