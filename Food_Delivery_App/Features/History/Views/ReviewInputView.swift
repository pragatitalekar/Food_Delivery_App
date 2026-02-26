//
//  ReviewInputView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/25/26.
//

import SwiftUI

struct ReviewInputView: View {
    
    @EnvironmentObject var orders: OrderManager
    var order: Order
    
    @State private var rating: Int = 0
    @State private var comment: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            rating = star
                        }
                }
            }
            
            TextField("Write a review...", text: $comment)
                .textFieldStyle(.roundedBorder)
            
            Button {
                orders.submitReview(
                    for: order,
                    rating: rating,
                    comment: comment
                )
            } label: {
                Text("Submit Review")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        rating == 0 || comment.isEmpty
                        ? Color.gray.opacity(0.3)
                        : AppColors.primary
                    )
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            .disabled(rating == 0 || comment.isEmpty)
        }
        .padding(.top, 6)
    }
}
