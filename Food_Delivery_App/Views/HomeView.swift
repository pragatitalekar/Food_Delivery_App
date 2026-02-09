//
//  HomeView.swift
//  Food_Delivery_Mini_App
//
//  Created by rentamac on 2/4/26.
//

import SwiftUI


struct HomeView: View {
    
    @State private var searchText = ""
    
    let foods = ["Pizza", "Burger", "Pasta", "Sandwich", "Biryani"]
    
    var filteredFoods: [String] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
    }
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView(.vertical){
                    VStack {
                        
                        Text("Delicious\nFood For You")
                            .font(.largeTitle)
                            .bold()
                            .padding(20)
                            .offset(x: -60, y: -60)
                        
                        NavigationLink {
                                           SearchView()
                                       } label: {
                                           HStack {
                                               Image(systemName: "magnifyingglass")
                                                   .foregroundColor(.gray)
                                               
                                               Text("Search")
                                                   .foregroundColor(.gray)
                                               
                                               Spacer()
                                           }
                                           .padding()
                                           .background(Color(.systemGray6))
                                           .cornerRadius(15)
                                           .offset(x: -5,y:-40)
                                       }
                                       .padding(.horizontal)
                        
                    }.frame(width:geo.size.width,height:geo.size.height * 0.5)
                    
                        .padding(.vertical)
                    

                    ScrollView(.horizontal){
                        
                        HStack(spacing:20){
                            
                            NavigationLink{
                                FoodView()
                                
                            }label:{
                                Text("Food")
                                    .font(.title2)
                                    .bold()
                                    .padding(10)
                            }
                            
                            
                            NavigationLink{
                                DrinksView()
                                
                            }label:{
                                Text("Drinks")
                                    .font(.title2)
                                    .bold()
                                    .padding(10)
                            }
                            
                            NavigationLink{
                                SnaksView()
                            }label: {
                                Text("Snacks")
                                    .font(.title2)
                                    .bold()
                                    .padding(10)
                            }
                            
                            
                        }.padding(.horizontal)
                            
                        
                    }.offset(x: 0, y: -120)
                    
                }
            }
        }
    }
    
}
#Preview {
    HomeView()
}
