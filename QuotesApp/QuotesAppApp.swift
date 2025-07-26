
import SwiftUI

@main
struct QuotesAppApp: App {
    var body: some Scene {
        WindowGroup {
            QuoteListView(viewModel: QuoteViewModel(service: QuoteService()))
        }
    }
}
