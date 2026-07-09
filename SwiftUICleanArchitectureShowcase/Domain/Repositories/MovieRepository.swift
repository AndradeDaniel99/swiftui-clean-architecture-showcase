protocol MovieRepository: Sendable {
    func searchMovies(query: String) async throws -> [MovieSearchResult]
    func movieDetails(id: String) async throws -> MovieDetails
}
