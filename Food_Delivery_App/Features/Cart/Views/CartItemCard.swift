import SwiftUI

struct CartItemCard: View {

    let item: FoodItems
    let quantity: Int

    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            // Image
            AsyncImage(url: URL(string: item.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())

            // Name + Price
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(1)

                Text("₹\(item.price, specifier: "%.0f")")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.orange)
            }

            Spacer()

            // Quantity Control
            HStack(spacing: 10) {

                Button(action: onDecrement) {
                    Text("-")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }.buttonStyle(.plain)


                Text("\(quantity)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)

                Button(action: onIncrement) {
                    Text("+")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }.buttonStyle(.plain)

            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.orange)
            .clipShape(Capsule())
        }
        .frame(width: 150)
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 3)
        .background(Color(.systemGray6))

    }
}
