//
//  Login.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import Foundation

struct LoginRequest: Codable {
    let email, password: String
}

struct LoginResponse: Codable {
    let token: String
}
