import SwiftUI

struct ItemCard: View {
    
    let item: FoodItems
    
    
    var body: some View {
        
        ZStack {
            
            // CARD
            VStack(spacing: 10) {
                
                Spacer().frame(height: 70) // space for image
                
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: 130)
                    .foregroundColor(AppColors.textPrimary)
                    .padding(15)
                
                Text("₹\(item.price, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primary)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 14)
            .frame(width: 165, height: 210)   // Slightly bigger
            .background(AppColors.background)          // solid white
            .cornerRadius(24)
            .shadow(color: AppColors.shadow
                    , radius: 8, x: 0, y: 4)
            

            AsyncImage(url: URL(string: item.image)) { img in
                img
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .shadow(color: AppColors.shadow
                    , radius: 8, x: 0, y: 4)
            .background(
                Circle().fill(Color.white)
            )
            
            .offset(y: -75)   // balanced offset
        }
        .frame(width: 165, height: 250)
    }
}

