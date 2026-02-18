import SwiftUI

struct ItemCard: View {
    
    let item: FoodItems
    
    
    var body: some View {
        
        ZStack {
            
            // CARD
            VStack(spacing: 10) {
                
                Spacer().frame(height: 60) // space for image
                
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: 130)
                    .foregroundColor(.black)
                
                Text("₹\(item.price, specifier: "%.0f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primary)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 14)
            .frame(width: 165, height: 210)   // Slightly bigger
            .background(Color.white)          // solid white
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 5)
            

            AsyncImage(url: URL(string: item.image)) { img in
                img
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 110, height: 110)
            .clipShape(Circle())
            .background(
                Circle().fill(Color.white)
            )
            .shadow(radius: 4)
            .offset(y: -75)   // balanced offset
        }
        .frame(width: 165, height: 230)
    }
}
