import Foundation
import Combine

class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
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
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }

                if text.isEmpty {
                    self.results = []
                } else {
                    self.results = self.allItems.filter {
                        $0.name.lowercased().contains(text.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
}
