//
//  UserListingCoordinator.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import Foundation
import UIKit

class UserListingCoordinator: Coordinator {
    // MARK: - Variables
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    func start() {
        guard let vc = R.storyboard.main.userListingVC() else {
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
    
    func gotoUserProfileScreen(of user: User) {
        let userProfileCoordinator = UserProfileCoordinator(navigationController: navigationController, user: user)
        userProfileCoordinator.start()
    }
}
