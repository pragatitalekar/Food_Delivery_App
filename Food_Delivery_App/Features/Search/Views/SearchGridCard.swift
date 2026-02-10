import SwiftUI

struct SearchGridCard: View {

    let item: FoodItems

    var body: some View {
        VStack(spacing: 10) {

            // MARK: - Circular Image
            AsyncImage(url: URL(string: item.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                        .foregroundColor(.gray)

                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 110, height: 110)
            .clipShape(Circle())

            // MARK: - Title
            Text(item.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 40)

            // MARK: - Price
            Text("₦\(Int(item.price))")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.orange)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 4)
    }
}
