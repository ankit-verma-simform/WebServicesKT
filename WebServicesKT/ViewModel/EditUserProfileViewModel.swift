//
//  EditUserProfileViewModel.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 04/07/23.
//

class EditUserProfileViewModel {
    func saveProfile(withUserId userId: Int,
                     saveUserRequest: SaveUserRequest,
                     completionHandler: @escaping (Bool) -> Void) {
        APIManager.shared.request(.updateProfile(userId: userId),
                                  body: saveUserRequest) {
            (result: Swift.Result<SaveUserResponse, NetworkError>) in

            switch result {
            case .failure(let error):
                print(error)
                completionHandler(false)
            case .success(let userResponse):
                print(userResponse)
                completionHandler(true)
            }
        }
    }
}
