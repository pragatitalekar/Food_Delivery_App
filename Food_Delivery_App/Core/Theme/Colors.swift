//
//  Colors.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI
import UIKit

struct AppColors {
    
    static let primary = Color(
        red: 250/255,
        green: 74/255,
        blue: 12/255
    )
    
    static let background = Color(UIColor.systemBackground)
    
    static let textPrimary = Color(UIColor.label)
    
    static let textSecondary = Color(UIColor.secondaryLabel)
    
    static let divider = Color(UIColor.separator)
    
    static let shadow = Color(UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white.withAlphaComponent(0.2)
        } else {
            return UIColor.black.withAlphaComponent(0.15)
        }
    })
    
    static let overlay = Color.black.opacity(0.3)
    
    static let white = Color.white
}


