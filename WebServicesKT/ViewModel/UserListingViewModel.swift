//
//  UserListingViewModel.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import Foundation

class UserListingViewModel {
    private (set) var users = LiveData([User]())
    private (set) var currentPage = LiveData(0)
    private (set) var totalPages = LiveData(0)
    private (set) var isLoadingData = LiveData(true)
    private (set) var isSearching = LiveData(false)
    private var usersFromApi = [User]() // caches latest api results
    
    func loadUsers() {
        loadUsersFromApi()
    }
    
    func filterUsers(searchQuery: String) {
        isSearching.value = true
        users.value = usersFromApi.filter { user in
            user.firstName.contains(searchQuery) || user.lastName.contains(searchQuery)
        }
    }
    
    func searchingCancelled() {
        users.value = usersFromApi
        isSearching.value = false
    }
    
    private func loadUsersFromApi() {
        isLoadingData.value = true
        currentPage.value += 1
        APIManager.shared.request(.getUsers(page: currentPage.value, perPage: 5, delay: 2)) { [weak self] (result: Swift.Result<UserList, NetworkError>) in
            guard let self else {
                return
            }
            
            switch result {
            case .failure(let error):
                self.currentPage.value -= 1
                print(error)
            case .success(let userList):
                print(userList)
                self.users.value += userList.users
                self.totalPages.value = userList.totalPages
                self.usersFromApi = self.users.value
            }
            self.isLoadingData.value = false
        }
    }
}
