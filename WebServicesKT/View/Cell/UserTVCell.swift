//
//  UserTVCell.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 03/07/23.
//

import UIKit
import Kingfisher

class UserTVCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet private weak var imgAvatar: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblEmail: UILabel!
    @IBOutlet private weak var lblId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Functions
extension UserTVCell {
    private func initialSetup() {
        imgAvatar.makeRounded()
    }
    
    func configure(with user: User) {
        lblName.text = "\(user.firstName) \(user.lastName)"
        lblEmail.text = user.email
        lblId.text = String(user.id)
        imgAvatar.kf.setImage(with: URL(string: user.avatar))
    }
}
