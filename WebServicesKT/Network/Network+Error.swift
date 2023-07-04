//
//  Network+Error.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

enum NetworkError: Error {
    case networkError(_ message: String? = nil)
    case serializationError(_ message: String? = nil)
    case deserializationError(_ message: String? = nil)
    case invalidResponse(_ message: String? = nil)
    case notOKResponse(_ message: String? = nil)
    case emptyBody(_ message: String? = nil)
}
