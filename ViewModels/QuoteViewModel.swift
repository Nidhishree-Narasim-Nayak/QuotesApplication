
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
        
        // Task group is created
        await withTaskGroup(of: Quote?.self) { group in
            let quoteList = try? await service.fetchQuotes()
            guard let quoteList else { return }
            // Adding task to the task Group
            for quote in quoteList.prefix(5) {
                group.addTask {
                    
                    // All these tasks run in parallel
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    await self.service.addQuotes("Another random quote")
                    return quote
                }
            }
            
            // Wait for the results and collect as they finish
            for await quote in group {
                if let quote = quote {
                    quotes.append(quote)
                }
            }
        }
        
        // When all the tasks are done the task group is exited
        isLoading = false
    }
}

