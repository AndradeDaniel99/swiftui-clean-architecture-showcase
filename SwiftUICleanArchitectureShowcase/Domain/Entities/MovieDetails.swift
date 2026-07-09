import Foundation

struct MovieDetails: Equatable, Sendable {
    let id: String
    let title: String
    let year: String
    let runtime: String
    let genre: String
    let director: String
    let plot: String
    let posterURL: URL?
}
