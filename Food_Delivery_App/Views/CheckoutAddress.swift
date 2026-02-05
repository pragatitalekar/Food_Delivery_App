//
//  CheckoutAddress.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/5/26.
//


import SwiftUI

struct CheckoutAddress: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Delivery")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .offset(x: -80, y: -250)
                 
                HStack {
                    Text("Address Details")
                        .font(.title3)
                        .padding()
                        .fontWeight(.medium)
                        .offset(x: -40 , y: -250)
                        
                    
                    
                    Text("change")
                        .font(.headline)
                        .foregroundStyle(Color.orange)
                        .offset(x: 30 , y: -250)
                        
                }
                .padding()
                
                
                CardView{
                    VStack(alignment: .leading, spacing: 10) {
                        Text ("#10, Brigade South Parade M.G. Road Bangalore 560001, India")
                    }
                    
                }
                .padding(.horizontal, 30)
                
                VStack {
                    Text("Delivery method")
                        .font(.title3)
                        .padding()
                        .fontWeight(.medium)
                        //.offset(x: -70 , y: -250)
                    
                }
                
                
                
                
            }
        }
        .navigationTitle("checkout")
    }
}

#Preview {
    CheckoutAddress()
}
