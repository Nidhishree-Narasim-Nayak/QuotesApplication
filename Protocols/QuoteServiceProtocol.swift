
import Foundation

protocol QuoteServiceProtocol: Sendable {
    func fetchQuotes() async throws -> [Quote]
    func addQuotes(_ content: String) async
}

