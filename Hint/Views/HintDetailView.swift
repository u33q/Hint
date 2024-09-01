
import SwiftUI

struct HintDetailView: View {
    let hint: Hint

    var body: some View {
        List {
            ForEach(hint.sections) { section in
                Section(section.title) {
                    ForEach(section.items) { item in
                        HStack {
                            Text(item.command)
                                .font(.system(.body, design: .monospaced))
                            Spacer()
                            Text(item.description)
                        }
                    }
                }
            }
        }
        .navigationTitle(hint.title)
    }
}
