import SwiftUI

struct SearchGridCard: View {
    let item: FoodItems

    var body: some View {
        VStack(alignment: .leading) {

            AsyncImage(url: URL(string: item.image)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 120)
            .cornerRadius(12)

            Text(item.name)
                .font(.headline)
                .lineLimit(1)

            Text("₹\(item.price, specifier: "%.0f")")
                .foregroundColor(.orange)
        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}
