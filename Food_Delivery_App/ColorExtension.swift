//
//  ColorExtension.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/5/26.
//

import SwiftUI

extension Color {
    
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        (r, g, b) = (
            (int >> 16) & 255,
            (int >> 8) & 255,
            int & 255
        )
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}
