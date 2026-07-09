import Foundation

struct MovieSearchResult: Identifiable, Equatable, Sendable {
    let id: String
    let title: String
    let year: String
    let posterURL: URL?
}
