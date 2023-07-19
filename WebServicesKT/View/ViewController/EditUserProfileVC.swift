//
//  EditUserProfileVC.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 04/07/23.
//

import UIKit
import SPIndicator

class EditUserProfileVC: UIViewController {
    // MARK: - Variables
    var user: User?
    var coordinator: EditUserProfileCoordinator?
    private lazy var viewModel = EditUserProfileViewModel()

    // MARK: - IB Outlets
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var btnCamera: UIButton!
    @IBOutlet private weak var tfFirstName: UITextField!
    @IBOutlet private weak var tfLastName: UITextField!
    @IBOutlet private weak var tfEmail: UITextField!
    @IBOutlet private weak var tfJob: UITextField!
    @IBOutlet private weak var tvBio: UITextView!
    @IBOutlet private weak var btnChangePassword: UIButton!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - Functions
extension EditUserProfileVC {
    private func initialSetup() {
        guard let user else {
            return
        }
        configureUserData(with: user)
        imgProfile.makeRounded()
        btnCamera.makeRounded()
        btnChangePassword.addBorder()
        setupNavbar()
    }
    
    private func setupNavbar() {
        navigationItem.title = R.string.localizable.editUserProfileTitle() 
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"),
                                         style: .plain, target: self, action: #selector(saveProfileButtonClicked))
        saveButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveProfileButtonClicked() {
        guard let user else {
            return
        }
        guard let firstName = tfFirstName.text,
              let lastName = tfLastName.text,
              let job = tfJob.text,
              !firstName.isEmpty, !lastName.isEmpty, !job.isEmpty else {
            return
        }
        let saveUserRequest = SaveUserRequest(name: "\(firstName) \(lastName)", job: job)
        viewModel.saveProfile(withUserId: user.id, saveUserRequest: saveUserRequest) { [weak self] profileUpdated in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                if profileUpdated {
                    SPIndicator.present(title: R.string.localizable.updateSuccess(), preset: .done)
                } else {
                    SPIndicator.present(title: R.string.localizable.updateFailed(), preset: .error)
                }
                self.coordinator?.finish()
            }
        }
    }
    
    private func configureUserData(with user: User) {
        tfFirstName.text = user.firstName
        tfLastName.text = user.lastName
        tfEmail.text = user.email
        tfJob.text = R.string.localizable.software()
        tvBio.text = R.string.localizable.supportReqres()
        imgProfile.kf.setImage(with: URL(string: user.avatar))
    }
}
