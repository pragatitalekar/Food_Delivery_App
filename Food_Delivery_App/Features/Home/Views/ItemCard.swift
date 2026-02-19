import SwiftUI

struct ItemCard: View {
    
    let item: FoodItems
    
    var body: some View {
        
        ZStack {
            
           
            VStack(spacing: 10) {
                
                Spacer().frame(height: 60)
                
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
            .frame(width: 165, height: 210)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 5)
            
            
        
            ZStack {
                
               
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
               
                AsyncImage(url: URL(string: item.image)) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(width: 105, height: 105)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.15), lineWidth: 2)
                        )
                        .mask(
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [
                                            Color.white,
                                            Color.white.opacity(0.9),
                                            Color.white.opacity(0.7),
                                            Color.clear
                                        ]),
                                        center: .center,
                                        startRadius: 30,
                                        endRadius: 60
                                    )
                                )
                        )
                } placeholder: {
                    ProgressView()
                }
            }
            .offset(y: -75)
        }
        .frame(width: 165, height: 230)
    }
}
