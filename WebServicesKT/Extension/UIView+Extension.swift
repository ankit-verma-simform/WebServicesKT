//
//  UIView+Extension.swift
//  WebServicesKT
//
//  Created by Ankit Verma on 04/07/23.
//

import UIKit

extension UIView {
    func addBorder(color: UIColor = UIColor.red) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
