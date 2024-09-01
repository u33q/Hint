
import Foundation

struct Hint: Identifiable, Codable, Hashable, Sendable {
    let id: String
    let title: String
    let sections: [Section]
    
    struct Section: Identifiable, Codable, Hashable, Sendable {
        let id: String
        let title: String
        let items: [Item]
    }
    
    struct Item: Identifiable, Codable, Hashable, Sendable {
        let id: String
        let command: String
        let description: String
    }
}
