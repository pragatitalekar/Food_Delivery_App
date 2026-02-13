//
//  AddPaymentView.swift
//  Food_Delivery_App
//
//  Created by rentamac on 2/12/26.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AddPaymentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var existingMethod: PaymentMethod?
    
    @State private var holderName = ""
    @State private var number = ""
    @State private var type = "Card"
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var ifsc = ""
    
    var onSave: () -> Void


    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Payment Type", selection: $type) {
                        Text("Card").tag("Card")
                        Text("Bank Account").tag("Bank account")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Account Details") {
                    TextField("Holder Name", text: $holderName)
                    TextField(type == "Card" ? "Card Number" : "Account Number", text: $number)
                        .keyboardType(.numberPad)
                    
                    if type == "Card" {
                        HStack {
                            TextField("Expiry (MM/YY)", text: $expiryDate)
                            TextField("CVV", text: $cvv)
                                .keyboardType(.numberPad)
                        }
                    } else {
                        TextField("IFSC Code", text: $ifsc)
                            .autocapitalization(.allCharacters)
                    }
                }
            }
            .navigationTitle("Add Payment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(holderName.isEmpty || number.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        
    }
    
    init(existingMethod: PaymentMethod? = nil, onSave: @escaping () -> Void) {
        
        self.existingMethod = existingMethod
        self.onSave = onSave
        
        _holderName = State(initialValue: existingMethod?.holderName ?? "")
        _number = State(initialValue: existingMethod?.number ?? "")
        _type = State(initialValue: existingMethod?.type ?? "Card")
        _expiryDate = State(initialValue: existingMethod?.expiryDate ?? "")
        _cvv = State(initialValue: existingMethod?.cvv ?? "")
        _ifsc = State(initialValue: existingMethod?.ifsc ?? "")
    }


    func save() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let id = existingMethod?.id ?? UUID().uuidString

        
        let method = PaymentMethod(
            id: id,
            type: type,
            holderName: holderName,
            number: number,
            expiryDate: type == "Card" ? expiryDate : nil,
            cvv: type == "Card" ? cvv : nil,
            ifsc: type == "Bank account" ? ifsc : nil
        )
        
        do {
            try Firestore.firestore()
                .collection("users").document(uid)
                .collection("paymentMethods").document(id)
                .setData(from: method)
            
            onSave()
            dismiss()
        } catch {
            print("Error saving payment: \(error)")
        }
    }
}
