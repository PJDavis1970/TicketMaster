//
//  UIView.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit

extension UIView {
        
    func borderStyle(color: UIColor, cornerRadius: CGFloat = 0, shadowRadius: CGFloat = 0.0, shadowOpacity: Float = 0.0, shadowOffset: CGSize = CGSize(width: 0,height: 0)) {
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowColor = color.cgColor
    }
}
