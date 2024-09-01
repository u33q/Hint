
import SwiftUI

struct HintDetailView: View {
    let hint: Hint

    var body: some View {
        List {
            ForEach(hint.sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        VStack(alignment: .leading) {
                            Text(item.command)
                                .font(.system(.body, design: .monospaced))
                            Text(item.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(hint.title)
        .onAppear {
            print("HintDetailView appeared for hint: \(hint.title)")
        }
    }
}
