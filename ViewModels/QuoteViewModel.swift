
import Foundation

@MainActor
class QuoteViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var isLoading = false
    
    private let service: QuoteServiceProtocol

    init( service: QuoteServiceProtocol) {
        self.service = service
    }
    
    func addQuotesOutsideOfTaskGroup() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        self.quotes.append(Quote(content: "Added a new quote ... Rosed are red ..."))
    }
    
    func loadQuotes() async {
        isLoading = true
        quotes.removeAll()
        
        await withTaskGroup(of: Quote?.self) { group in
            let quoteList = try? await service.fetchQuotes()
            guard let quoteList else { return }
            for quote in quoteList.prefix(5) {
                group.addTask {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    await self.service.addQuotes("Another random quote")
                    return quote
                }
            }
            
            for await quote in group {
                if let quote = quote {
                    quotes.append(quote)
                }
            }
        }
        isLoading = false
    }
}

