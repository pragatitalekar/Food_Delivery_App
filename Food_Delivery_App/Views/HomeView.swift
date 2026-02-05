//
//  HomeView.swift
//  Food_Delivery_Mini_App
//
//  Created by rentamac on 2/4/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Delicious Food \n For You")
                    .font(.largeTitle)
                    .bold()
                    .padding(20)
                    .offset(x: -40, y: -250)
               
               
                
                HStack{
                    
                        HStack{
                            NavigationLink{
                                FoodView()
                                
                            }label:{
                                Text("Food")
                                    .font(.title)
                                    .bold()
                            }.offset(x: -100, y: -100)
                            
                        }
                        HStack{
                            NavigationLink{
                                DrinksView()
                                
                            }label:{
                                Text("Drinks")
                                    .font(.title)
                                    .bold()
                            }.offset(x: -100, y: -100)
                            
                        }
                    
                        
                    }
                }
            }
        }
    }

#Preview {
    HomeView()
}
