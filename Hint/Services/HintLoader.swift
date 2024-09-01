
import Foundation

actor HintLoader {
    private let decoder: JSONDecoder
    private let bundle: Bundle
    
    init(decoder: JSONDecoder = JSONDecoder(), bundle: Bundle = .main) {
        self.decoder = decoder
        self.bundle = bundle
    }
    
    func loadHints() async throws -> [Hint] {
        let hintConfigs = try await loadHintConfigs()
        
        return try await withThrowingTaskGroup(of: Hint.self, returning: [Hint].self) { group in
            for config in hintConfigs {
                group.addTask { try await self.loadHint(from: config.filename) }
            }
            
            // Collect results within the actor-isolated context
            var hints: [Hint] = []
            for try await hint in group {
                hints.append(hint)
            }
            
            // Sort the hints within the actor-isolated context
            return hints.sorted { $0.title < $1.title }
        }
    }
    
    private func loadHintConfigs() async throws -> [HintConfig] {
        let data = try await loadData(from: "hints", withExtension: "json")
        return try decoder.decode([HintConfig].self, from: data)
    }
    
    private func loadHint(from filename: String) async throws -> Hint {
        let data = try await loadData(from: filename, withExtension: "json")
        return try decoder.decode(Hint.self, from: data)
    }
    
    private func loadData(from resource: String, withExtension ext: String) async throws -> Data {
        try await Task.detached {
            guard let url = self.bundle.url(forResource: resource, withExtension: ext) else {
                throw HintError.fileNotFound(resource)
            }
            return try Data(contentsOf: url)
        }.value
    }
}

private struct HintConfig: Codable, Sendable {
    let filename: String
}

enum HintError: Error {
    case fileNotFound(String)
}
