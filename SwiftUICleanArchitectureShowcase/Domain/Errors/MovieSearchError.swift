enum MovieSearchError: Error, Equatable, Sendable {
    case emptyQuery
    case noResults
    case invalidResponse
    case requestFailed
}
