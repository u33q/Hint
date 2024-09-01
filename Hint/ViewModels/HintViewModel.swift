
import SwiftUI

@MainActor
class HintViewModel: ObservableObject {
    @Published var hints: [Hint] = []
    @Published var selectedHint: Hint?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let loader: HintLoader
    
    init(loader: HintLoader = HintLoader()) {
        self.loader = loader
    }
    
    func loadHints() async {
        isLoading = true
        errorMessage = nil
        
        do {
            hints = try await loader.loadHints()
            print("Loaded \(hints.count) hints")
        } catch {
            errorMessage = "Failed to load hints: \(error.localizedDescription)"
            print("Error loading hints: \(error)")
        }
        
        isLoading = false
    }
    
    func selectHint(_ hint: Hint?) {
        selectedHint = hint
        print("Selected hint in ViewModel: \(hint?.title ?? "nil")")
    }
}
