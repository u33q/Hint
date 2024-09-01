
import SwiftUI

struct MenuBarView: View {
    // Access the shared view model
    @EnvironmentObject private var viewModel: HintViewModel
    // Track the currently selected hint
    @State private var selectedHint: Hint?

    var body: some View {
        NavigationSplitView {
            // Display the list of hints
            List(viewModel.hints, selection: $selectedHint) { hint in
                Text(hint.title)
                    .tag(hint)
            }
            .navigationTitle("Hints")
        } detail: {
            // Display the selected hint or a placeholder
            if let hint = selectedHint {
                HintDetailView(hint: hint)
            } else {
                Text("Select a hint")
            }
        }
        .frame(width: 500, height: 300)
        .task {
            // Load hints when the view appears
            await viewModel.loadHints()
        }
        .onAppear {
            print("MenuBarView appeared with \(viewModel.hints.count) hints")
        }
    }
}
