//
//  QuoteServiceProtocol.swift
//  QuotesApp
//
//  Created by Nidhishree Nayak on 22/07/25.
//

import Foundation

protocol QuoteServiceProtocol: Sendable {
    func fetchQuotes() async throws -> [Quote]
    func addQuotes(_ content: String) async
}

