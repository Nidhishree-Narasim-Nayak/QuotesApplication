
import SwiftUI

struct QuoteListView: View {
    @StateObject private var viewModel: QuoteViewModel
    init(viewModel: QuoteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Quotes")
                        .padding()
                } else {
                    List(viewModel.quotes) { quote in
                        Text(quote.content)
                    }
                }
                HStack {
                    Button("Fetch Quotes") {
                        Task {
                            await viewModel.loadQuotes()
                        }
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                    Button("Add Quote") {
                        Task {
                            await viewModel.addQuotesOutsideOfTaskGroup()
                        }
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Quotes")
        }
    }
}

#Preview {
    QuoteListView(viewModel: QuoteViewModel(service: QuoteService()))
}
