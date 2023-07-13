//
//  LoginViewModel.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import Foundation

enum LoginState {
    case success(token: String), failure(errorMessage: String)
}

class LoginViewModel {
    
    func login(email: String, password: String, completionHandler: @escaping (LoginState) -> Void) {
        let loginRequest = LoginRequest(email: email, password: password)
        APIManager.shared.request(.login, body: loginRequest) {
            (result: Swift.Result<LoginResponse, NetworkError>) in
            switch result {
            case .failure(let error):
                print(error)
                completionHandler(.failure(errorMessage: error.localizedDescription))
            case .success(let response):
                print(response)
                completionHandler(.success(token: response.token))
            }
        }
    }
}
