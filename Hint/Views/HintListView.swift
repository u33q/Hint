
import SwiftUI

struct HintListView: View {
    let hints: [Hint]
    @Binding var selectedHint: Hint?

    var body: some View {
        List(hints, selection: $selectedHint) { hint in
            Text(hint.title)
        }
        .navigationTitle("Hints")
        .onAppear {
            print("HintListView appeared with \(hints.count) hints") 
        }
    }
}
