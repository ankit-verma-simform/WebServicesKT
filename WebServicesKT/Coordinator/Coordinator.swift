//
//  Coordinator.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func finish()
}
