import Foundation
import Combine

class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var selectedCategory: CategoryType? = nil
    @Published var results: [FoodItems] = []

    private var allItems: [FoodItems] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSearch()
    }

    func updateItems(_ items: [FoodItems]) {
        self.allItems = items
    }

    private func setupSearch() {
        Publishers.CombineLatest($searchText, $selectedCategory)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text, category in
                guard let self else { return }

                self.results = self.allItems.filter { item in
                    let matchesText =
                        text.isEmpty ||
                        item.name.lowercased().contains(text.lowercased())

                    let matchesCategory =
                        category == nil || item.category == category

                    return matchesText && matchesCategory
                }
            }
            .store(in: &cancellables)
    }
}
