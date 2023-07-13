//
//  AppCoordinator.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    // MARK: - Variables
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    func finish() {}
}
