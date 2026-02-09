//
//  NavigationManager.swift
//  Food_Delivery_App
//
//  Created by Bhaswanth on 2/6/26.
//

import SwiftUI
import Combine

class NavigationManager: ObservableObject {
    
    static let shared = NavigationManager()
    
    @Published var showSideMenu: Bool = false
    
    @Published var path = NavigationPath()
    
}



