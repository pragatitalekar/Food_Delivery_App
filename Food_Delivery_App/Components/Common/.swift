//
//  RoundedCorner.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/7/26.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = 40
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}
