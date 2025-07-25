//
//  MockQuoteService.swift
//  QuotesApp
//
//  Created by Nidhishree Nayak on 25/07/25.
//

import Foundation

actor MockQuoteService: QuoteServiceProtocol {
    
    private(set) var fetchCalled = false
    private(set) var addedQuotes: [String] = []
    func fetchQuotes() async throws -> [Quote] {
        fetchCalled = true
        return [
            Quote(content: "Treat people how you like to be treated"),
            Quote(content: "Canadiens can't jump"),
            Quote(content: "Sticks and stones"),
            Quote(content: "Teach a man how to fish"),
            Quote(content: "Each one teach one.")
        ]
    }
    
    func addQuotes(_ content: String) async {
        addedQuotes.append(content)
    }
}
