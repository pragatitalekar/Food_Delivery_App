//
//  EditAddressView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/11/26.
//


import SwiftUI

struct EditAddressView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddressViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Edit Details")
                .font(.headline)
            
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Street Address", text: $viewModel.street)
                .textFieldStyle(.roundedBorder)
            
            TextField("Phone Number", text: $viewModel.phone)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.phonePad)
            
            
            Button {
                viewModel.saveAddress()
                dismiss()
            } label: {
                Text("Save Address")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            
        }
        .padding()
    }
}


//#Preview {
//    EditAddressView()
//        .environmentObject(<#T##object: ObservableObject##ObservableObject#>)
//}
