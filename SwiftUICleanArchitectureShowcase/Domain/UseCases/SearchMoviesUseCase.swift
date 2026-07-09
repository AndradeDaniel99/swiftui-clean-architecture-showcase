import Foundation

struct SearchMoviesUseCase: Sendable {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [MovieSearchResult] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmedQuery.isEmpty == false else {
            throw MovieSearchError.emptyQuery
        }

        return try await repository.searchMovies(query: trimmedQuery)
    }
}
