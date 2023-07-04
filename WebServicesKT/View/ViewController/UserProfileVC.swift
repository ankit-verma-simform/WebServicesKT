//
//  UserProfileVC.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 04/07/23.
//

import UIKit

class UserProfileVC: UIViewController {
    // MARK: - Variables
    var user: User?
    
    // MARK: - IB Outlets
    @IBOutlet private weak var btnLogout: UIButton!
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var lblUsername: UILabel!
    @IBOutlet private weak var lblEmail: UILabel!
    @IBOutlet private weak var lblBio: UILabel!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - Functions
extension UserProfileVC {
    private func initialSetup() {
        styleLogoutButton()
        customizeNavbar()
        styleProfileImage()
        guard let user else {
            return
        }
        configureUserData(with: user)
    }
    
    private func styleLogoutButton() {
        btnLogout.addBorder()
    }
    
    private func customizeNavbar() {
        navigationItem.title = "Profile"
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                         style: .plain, target: self, action: #selector(editProfileButtonClicked))
        editButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backButtonTitle = ""
    }
    
    @objc private func editProfileButtonClicked() {
        guard let vc = storyboard?.instantiateViewController(
            withIdentifier: EditUserProfileVC.identifier) as? EditUserProfileVC else {
            return
        }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func styleProfileImage() {
        imgProfile.makeRounded()
    }
    
    private func configureUserData(with user: User) {
        lblUsername.text = "\(user.firstName) \(user.lastName)"
        lblEmail.text = user.email
        lblBio.text = "Support Reqres!"
        imgProfile.kf.setImage(with: URL(string: user.avatar))
    }
}
