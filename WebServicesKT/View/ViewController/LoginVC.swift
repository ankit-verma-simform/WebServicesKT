//
//  LoginVC.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 13/07/23.
//

import UIKit
import SPIndicator

class LoginVC: UIViewController {
    // MARK: - Variables
    var coordinator: LoginCoordinator?
    private let viewModel = LoginViewModel()
    
    // MARK: - IB Outlets
    @IBOutlet private weak var imgMain: UIImageView!
    @IBOutlet private weak var btnLogin: UIButton!
    @IBOutlet private weak var tfEmail: UITextField!
    @IBOutlet private weak var tfPassword: UITextField!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - IB Actions
extension LoginVC {
    @IBAction private func btnLoginClicked(_ sender: Any) {
        guard let email = tfEmail.text,
              let password = tfPassword.text else {
            return
        }
        viewModel.login(email: email, password: password) { [weak self] loginState in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                switch loginState {
                case .success(let token):
                    self.coordinator?.gotoUserListingScreen()
                    self.showLoginSuccessNotification(with: token)
                case .failure:
                    self.showLoginFailedNotification()
                }
            }
        }
    }
}

// MARK: - Functions
extension LoginVC {
    private func initialSetup() {
        imgMain.makeRounded()
        btnLogin.addBorder()
    }
    
    private func showLoginFailedNotification(with errorMessage: String? = nil) {
        SPIndicator.present(title: R.string.localizable.loginFailed(), message: errorMessage, preset: .error)
    }
    
    private func showLoginSuccessNotification(with message: String) {
        SPIndicator.present(title: R.string.localizable.loginSuccess(), message: message, preset: .done)
    }
}
