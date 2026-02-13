import SwiftUI

struct SearchView: View {

    @ObservedObject var homeVM: HomeViewModel
    @StateObject private var vm = SearchViewModel()
    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Search Bar
            HStack {
                TextField("Search food or drink", text: $vm.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding()

            // MARK: - Category Filter (No "All")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(CategoryType.allCases, id: \.self) { category in
                        Button {
                            // Toggle category
                            vm.selectedCategory =
                            vm.selectedCategory == category ? nil : category
                        } label: {
                            Text(category.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    vm.selectedCategory == category
                                    ? Color.primaryOrange
                                    : Color(.systemBackground)
                                )
                                .foregroundColor(
                                    vm.selectedCategory == category
                                    ? .white
                                    : .primary
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            Color.primaryOrange.opacity(0.35),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }

            // MARK: - Result Count
            if !vm.searchText.isEmpty || vm.selectedCategory != nil {
                Text("Found \(vm.results.count) results")
                    .font(.headline)
                    .padding(.vertical, 8)
            }

            // MARK: - Results Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.results) { item in
                        NavigationLink {
                            DetailView(item: item)
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
        .onAppear {
            vm.updateItems(homeVM.allItems)
        }
    }
}
