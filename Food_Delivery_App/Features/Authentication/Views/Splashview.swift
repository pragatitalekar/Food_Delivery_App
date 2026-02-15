//
//  Splashview.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/10/26.
//

import SwiftUI
import Combine

struct SplashView: View {
    
    @State private var navigate = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color("#FF4B3A")
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        ZStack {
                               Circle()
                                   .fill(Color.white)
                                   .frame(width: 64, height: 64)

                               Image("logo")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 36, height: 36)
                           }
                        
                        Text("Food for\nEveryone")
                            .font(.system(size: 65, weight: .heavy, design: .rounded))
                            .kerning(-2)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    
                    ZStack {
                        
                        Image("characterback")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 260)
                            .rotationEffect(.degrees(8.57))
                            .offset(x: 100, y: 40)
                        
                        
                        Image("characterfront")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 340)
                            .rotationEffect(.degrees(-3.1))
                            .offset(x: -82)
                        
                        
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.clear, location: 0.0),
                                .init(color: Color("#FF4B3A").opacity(0.4), location: 0.35),
                                .init(color: Color("#FF4B3A"), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 420)
                        .offset(y: 70)
                    }

                    
                    Spacer()
                    
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Text("Get started")
                            .foregroundColor(Color("#FF4B3A"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(30)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
                .background(Color("#FF4B3A").ignoresSafeArea())
                .navigationDestination(isPresented: $navigate) {
                    AuthView()
                }
            }

        }
    }
}
