@testable import SwiftUICleanArchitectureShowcase

final class FakeMovieRepository: MovieRepository, @unchecked Sendable {
    var searchResult: Result<[MovieSearchResult], Error> = .success([])
    var detailsResult: Result<MovieDetails, Error> = .failure(MovieSearchError.noResults)
    private(set) var lastSearchQuery: String?

    func searchMovies(query: String) async throws -> [MovieSearchResult] {
        lastSearchQuery = query
        return try searchResult.get()
    }

    func movieDetails(id: String) async throws -> MovieDetails {
        try detailsResult.get()
    }
}
