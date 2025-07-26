
import Foundation

class QuoteService: QuoteServiceProtocol {
    
    private var quotes: [Quote] = [
        Quote(content: "Don't throw pearls before swine."),
        Quote(content: "Sticks and stones may break my bones, but names don't hurt me."),
        Quote(content: "Finders keepers loosers weepers."),
        Quote(content: "Better you than me."),
    ]
    
    /// method makes this process wait for one second and then fetches quotes
    /// - Returns: array of Quote
    func fetchQuotes() async throws -> [Quote] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return quotes.shuffled()
    }
    
    func addQuotes(_ content: String) async {
        quotes.append(Quote(content: content))
    }
}
