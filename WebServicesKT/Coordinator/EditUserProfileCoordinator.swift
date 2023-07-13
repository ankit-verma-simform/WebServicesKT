//
//  EditUserProfileCoordinator.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import Foundation
import UIKit

class EditUserProfileCoordinator: Coordinator {
    // MARK: - Variables
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var user: User
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }

    // MARK: - Functions
    func start() {
        guard let vc = R.storyboard.main.editUserProfileVC() else {
            return
        }
        vc.coordinator = self
        vc.user = user
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
}
