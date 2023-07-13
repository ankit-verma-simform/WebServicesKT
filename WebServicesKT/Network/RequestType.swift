//
//  RequestType.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

enum RequestType {
    case getUsers(page: Int, perPage: Int = 6, delay: Int = 0)
    case updateProfile(userId: Int)
    case login
}

extension RequestType: Endpoint {
    var baseUrl: String {
        return "https://reqres.in/api/"
    }
    
    var path: String {
        switch self {
        case .getUsers(let page, let perPage, let delay):
            return "users?page=\(page)&per_page=\(perPage)&delay=\(delay)"
        case .updateProfile(userId: let userId):
            return "users/\(userId)"
        case .login:
            return "login"
        }
    }
    
    var version: String {
        return ""
    }
    
    var method: RequestMethod {
        switch self {
        case .getUsers:
            return .get
        case .updateProfile:
            return .patch
        case .login:
            return .post
        }
    }
    
    var url: URL {
        return URL(string: baseUrl + version + path)!
    }
    
    var headers: [String : String]? {
        switch self {
        case .updateProfile, .login:
            return [
                "Accept":"application/json",
                "Content-Type":"application/json"
            ]
        default:
            return nil
        }
    }
}
