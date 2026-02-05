//
//  ContentView.swift
//  Food_Delivery_Mini_App
//
//  Created by rentamac on 2/3/26.
//

import SwiftUI

struct ContentView: View {
    //let header: String
    var body: some View {
        NavigationStack{
           
            
            HStack{
                
            
                VStack(alignment: .leading){
                    
                    NavigationLink{
                        AddCartView()
                        
                    }label: {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                    
                    .padding(6)
                    .offset(x: 195,y: 10)
                    
                }
                
                VStack{
                    NavigationLink{
                        MoreView()
                        
                    }label: {
                            Image(systemName: "ellipsis")
                            .font(.title)
                    }
                    .padding(6)
                    .offset(x: -195,y: 10)
                }
                }
                
            
          
            
            
            
            TabView{
                
                Tab(Constants.homeString,systemImage:Constants.homeIconString){
                    HomeView()
                    
                }
                Tab(Constants.likedString,systemImage:Constants.likedIconString){
                    LikedView()
                    
                }
                
                Tab(Constants.profileString,systemImage:Constants.profileIconString){
                    
                }
                
                Tab(Constants.historyString,systemImage: Constants.historyIconString){
                    
                }
                
                
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
