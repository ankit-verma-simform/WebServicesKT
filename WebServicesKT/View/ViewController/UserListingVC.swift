//
//  UserListingVC.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import UIKit

class UserListingVC: UIViewController {
    // MARK: - Variables
    private lazy var viewModel = UserListingViewModel()
    var coordinator: UserListingCoordinator?
    
    // MARK: - IB Outlets
    @IBOutlet private weak var tblUsers: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - UI Table View Delegate & DataSource Methods
extension UserListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.userTVCell, for: indexPath) else {
            return UITableViewCell()
        }
        userCell.configure(with: viewModel.users.value[indexPath.row])
        return userCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.users.value.count - 1,
           !viewModel.isSearching.value,
           viewModel.currentPage.value < viewModel.totalPages.value,
           !viewModel.isLoadingData.value {
            viewModel.loadUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clickedUser = viewModel.users.value[indexPath.row]
        coordinator?.gotoUserProfileScreen(of: clickedUser)
    }
}

// MARK: - Searchbar Delegate Methods
extension UserListingVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.searchingCancelled()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchQuery = searchBar.text else {
            return
        }
        viewModel.filterUsers(searchQuery: searchQuery)
    }
}

// MARK: - Functions
extension UserListingVC {
    private func initialSetup() {
        navigationItem.setHidesBackButton(true, animated: false)
        setupTableView()
        setupActivityIndicator()
        viewModel.loadUsers()
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tblUsers.delegate = self
        tblUsers.dataSource = self
        tblUsers.register(R.nib.userTVCell)
        
        viewModel.users.bind { [weak self] users in
            print(users.count)
            DispatchQueue.main.async {
                self?.tblUsers.reloadData()
            }
        }
    }
    
    private func setupActivityIndicator() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
