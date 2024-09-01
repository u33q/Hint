import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject private var viewModel: HintViewModel
    @State private var selectedHint: Hint?

    var body: some View {
        NavigationSplitView {
            List(viewModel.hints, selection: $selectedHint) { hint in
                Text(hint.title)
                    .tag(hint)
            }
            .navigationTitle("Hints")
        } detail: {
            if let hint = selectedHint {
                HintDetailView(hint: hint)
            } else {
                Text("Select a hint")
            }
        }
        .frame(width: 500, height: 300)
        .task {
            await viewModel.loadHints()
        }
        .onAppear {
            print("MenuBarView appeared with \(viewModel.hints.count) hints")
        }
    }
}
