
import XCTest
@testable import QuotesApp

@MainActor
final class QuoteViewModelTests: XCTestCase {
    
    func testAddQuotesOutsideOfTaskGroupsAppendQuote() async {
        let mockService = MockQuoteService()
        let viewModel = QuoteViewModel(service: mockService)
        
        // Initially the quotes array is 0 because its asynchronous, so its going to take a minute before we see the elements in the array but the tests happen immediately. It tests the results before it returns. There is going to be a lag
        XCTAssertEqual(viewModel.quotes.count, 0)
        
        await viewModel.addQuotesOutsideOfTaskGroup()
        XCTAssertEqual(viewModel.quotes.count, 1)
        
        XCTAssertEqual(viewModel.quotes.first?.content, "Added a new quote ... Rosed are red ...")
    }
    
    func testLoadQuotesLoadShuffledQuotesAndAddsOne() async {
        let mockService = MockQuoteService()
        let viewModel = QuoteViewModel(service: mockService)
        
        await viewModel.loadQuotes()
        
        XCTAssertEqual(viewModel.quotes.count, 5)
        
        let addedQuotes = await mockService.addedQuotes
        XCTAssertEqual(addedQuotes.count, 5)
        XCTAssertTrue(addedQuotes.allSatisfy{ $0 == "Another random quote"})
    }
    
    func testLoadStateSetProperly() async {
        let mockService = MockQuoteService()
        let viewModel = QuoteViewModel(service: mockService)
        XCTAssertFalse(viewModel.isLoading)
        
        let task = Task {
            await viewModel.loadQuotes()
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertTrue(viewModel.isLoading)
        await task.value
        XCTAssertFalse(viewModel.isLoading)
    }
}
