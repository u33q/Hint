
import SwiftUI

@main
struct HintApp: App {
    // Create a shared view model instance
    @StateObject private var viewModel = HintViewModel()

    var body: some Scene {
        // Define the menu bar extra with a custom view
        MenuBarExtra("Hint", systemImage: "lightbulb") {
            MenuBarView()
                .environmentObject(viewModel)
                .frame(width: 500, height: 300)
        }
        .menuBarExtraStyle(.window)

        Settings { EmptyView() }
    }
}
