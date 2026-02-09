import SwiftUI

struct SearchView: View {

    @StateObject var vm: SearchViewModel
    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Top Bar
            HStack(spacing: 12) {

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }

                TextField("Search", text: $vm.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding()

            // MARK: - Result Count
            if !vm.searchText.isEmpty {
                Text("Found \(vm.results.count) results")
                    .font(.headline)
                    .padding(.vertical, 8)
            }

            // MARK: - Grid Results
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.results) { item in
                        NavigationLink {
                            ProductDetailedView()
                        } label: {
                            SearchGridCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }

                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        SearchView(
            vm: SearchViewModel(items: mockFoodItems)
        )
    }
}

let mockFoodItems: [FoodItems] = [
    FoodItems(
        id: UUID(),
        name: "Veggie tomato mix",
        image: "https://bing.com/th?id=OSK.d1eb0a0ed71228fccb9c47a8d2ce6e71",
        description: "Healthy veggie meal",
        price: 1900,
        category: .meals
    ),
    FoodItems(
        id: UUID(),
        name: "Egg and cucumber",
        image: "https://img.freepik.com/premium-photo/fresh-cucumber-boiled-egg-salad-with-parsley-garnish-cucumber-breakfast-salad-with-jammy-eggs_616001-38276.jpg",
        description: "Egg with cucumber",
        price: 1900,
        category: .meals
    ),
    FoodItems(
        id: UUID(),
        name: "Fried chicken mix",
        image: "https://bing.com/th?id=OSK.5676db5685a63501f8400b42a872d251",
        description: "Crispy fried chicken",
        price: 1900,
        category: .meals
    ),
    FoodItems(
        id: UUID(),
        name: "fried egg",
        image: "https://bing.com/th?id=OSK.b9774e6819b03146e48e213bbae3f14f",
        description: "Traditional meal",
        price: 1900,
        category: .meals
    )
]
