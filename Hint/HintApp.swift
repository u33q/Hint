
import SwiftUI

@main
struct HintApp: App {
    @StateObject private var viewModel = HintViewModel()

    var body: some Scene {
        MenuBarExtra("Hint", systemImage: "lightbulb") {
            MenuBarView()
                .environmentObject(viewModel)
                .frame(width: 500, height: 300)
        }
        .menuBarExtraStyle(.window)

        Settings { EmptyView() }
    }
}
