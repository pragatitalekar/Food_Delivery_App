import SwiftUI

struct DetailedView: View {

    var body: some View {
        VStack {

            // Scrollable content
            ScrollView {
                VStack(spacing: 0) {

                    Image("food") // replace with asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .clipShape(Circle())
                        .padding(.top, 20)

                    // Page indicators
                    HStack(spacing: 6) {
                        Circle().fill(Color.orange).frame(width: 6, height: 6)
                        Circle().fill(Color.gray.opacity(0.3)).frame(width: 6, height: 6)
                        Circle().fill(Color.gray.opacity(0.3)).frame(width: 6, height: 6)
                        Circle().fill(Color.gray.opacity(0.3)).frame(width: 6, height: 6)
                    }
                    .padding(.top, 8)

                    // Title & price
                    VStack(spacing: 8) {
                        Text("Veggie tomato mix")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("₦1,900")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 30)

                    // Info sections
                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Delivery info")
                                .font(.headline)

                            Text("Delivered between monday aug and thursday 20 from 8pm - 9:13 pm")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Return policy")
                                .font(.headline)

                            Text("All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)

                    Spacer() // space so content isn't hidden by button
                }
            }

            // Sticky Add to Cart button
            Button {
                // add to cart action
            } label: {
                Text("Add to cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.bottom)
            Spacer()
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // favorite action
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailedView()
    }
}
