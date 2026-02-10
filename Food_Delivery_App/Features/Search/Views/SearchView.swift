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

            
            HStack(spacing: 12) {

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }

                TextField("Search food or drink", text: $vm.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding()

         
            if !vm.searchText.isEmpty {
                Text("Found \(vm.results.count) results")
                    .font(.headline)
                    .padding(.vertical, 8)
            }

      
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
