//
//  ProfileOtherMenu.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        List {
            DisclosureGroup("How do I track my order?") {
                Text("Go to the Orders tab in your profile to see real-time updates.")
                    .font(.subheadline).foregroundColor(.secondary)
            }
            DisclosureGroup("What is the return policy?") {
                Text("You can cancel orders within 5 minutes of placing them.")
                    .font(.subheadline).foregroundColor(.secondary)
            }
        }
        .navigationTitle("FAQ")
    }
}

struct HelpView: View {
    @State private var showingMailAlert = false
    private let supportEmail = "fooddelivery@gmail.com"

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "headphones.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(AppColors.primary)
            
            Text("How can we help you?")
                .font(.title2).bold()
            
            Text("Our support team is available 24/7 to assist you with your orders.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                showingMailAlert = true
            }) {
                Label("Contact Support", systemImage: "message.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding()
        }
        .navigationTitle("Help")
        .alert("Contact Support", isPresented: $showingMailAlert) {
            Button("Send") {
                sendEmail()
            }
            Button("OK", role: .cancel) { }
        } message: {
            Text("Mail us at \(supportEmail) for any queries or support.")
        }
    }

    private func sendEmail() {
        let mailto = "mailto:\(supportEmail)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: mailto) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
