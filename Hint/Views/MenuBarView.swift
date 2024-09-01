
import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject private var viewModel: HintViewModel
    @State private var selectedHint: Hint?

    var body: some View {
        NavigationSplitView {
            HintListView(hints: viewModel.hints, selectedHint: $selectedHint)
        } detail: {
            if let hint = selectedHint {
                HintDetailView(hint: hint)
            } else {
                Text("Select a hint")
            }
        }
        .frame(width: 600, height: 400)
        .task {
            await viewModel.loadHints()
        }
        .onAppear {
            print("MenuBarView appeared")
        }
    }
}
