import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var cart: CartManager
    @EnvironmentObject var orders: OrderManager
    
    var address: String
    var deliveryType: String
    var paymentType: String
    
    var onCancel: () -> Void
    var onSuccess: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Please note")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                
                noteRow(
                    title: "DELIVERY TO",
                    price: address
                )

                Divider()
                
                noteRow(
                    title: "RECIPIENT ",
                    price: deliveryType
                )

                Divider()
                
                noteRow(
                    title: "PAYMENT METHOD",
                    price: paymentType.capitalized
                )
            }
            
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .foregroundColor(.secondary)

                Spacer()
                
                Button {
                    placeOrder()
                } label: {
                    Text("Proceed")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }
    
    private func noteRow(title: String, price: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(price)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
   
    private func placeOrder() {
        
        guard !address.isEmpty else { return }
        
        orders.placeOrder(
            items: cart.items.values.map { $0.item },
            total: cart.total
        )
        
        cart.items.removeAll()
        
        onSuccess()
    }
}
