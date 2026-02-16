import SwiftUI
import UIKit

struct AppColors {
    
    static let primary = Color(
        red: 250/255,
        green: 74/255,
        blue: 12/255
    )
    
    static let primaryOrange = Color(
        red: 255/255,
        green: 75/255,
        blue: 58/255
    )
    
    static let lightBackground = Color(
        red: 242/255,
        green: 242/255,
        blue: 242/255
    )
    
    static let background = Color(UIColor.systemBackground)
    
    static let textPrimary = Color(UIColor.label)
    
    static let textSecondary = Color(UIColor.secondaryLabel)
    
    static let divider = Color(UIColor.separator)
    
    static let error = Color.red
    
    static let white = Color.white
    
    static let overlay = Color.black.opacity(0.3)
    
    static let shadow = Color(UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.white.withAlphaComponent(0.2)
        } else {
            return UIColor.black.withAlphaComponent(0.15)
        }
    })
}
