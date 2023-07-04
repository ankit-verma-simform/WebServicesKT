//
//  Network+Endpoint.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var version: String { get }
    var method: RequestMethod { get }
    var url: URL { get }
    var headers: [String : String]? { get }
}
