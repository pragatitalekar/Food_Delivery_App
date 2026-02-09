import SwiftUI
import Combine

class SearchViewModel: ObservableObject {

    // MARK: - Input
    @Published var searchText: String = ""

    // MARK: - Output
    @Published private(set) var results: [FoodItems] = []

    // MARK: - Private
    private let allItems: [FoodItems]
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(items: [FoodItems]) {
        self.allItems = items
        setupSearch()
    }

    // MARK: - Search Logic
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { text in
                guard !text.isEmpty else { return [] }
                return self.allItems.filter {
                    $0.name.lowercased().contains(text.lowercased())
                }
            }
            .assign(to: &$results)
    }
}

