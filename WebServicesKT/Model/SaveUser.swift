//
//  SaveUser.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 04/07/23.
//

struct SaveUserResponse: Codable {
    let name, job, updatedAt: String
}

struct SaveUserRequest: Codable {
    let name, job: String
}
