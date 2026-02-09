//
//  DashboardView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/8/26.
//

import SwiftUI
import Combine
struct DashboardView: View {
    var body: some View {
        NavigationStack{
           
            
            HStack{
                
                
                VStack(alignment: .leading){
                    
                    NavigationLink{
                        CartView()
                        
                    }label: {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                    
                    .padding(6)
                    .offset(x: 195,y: 10)
                    
                }
                
                VStack{
                    NavigationLink{
                        SideMenuView()
        
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
                    FavouriteView()
                    
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
    DashboardView()
}
