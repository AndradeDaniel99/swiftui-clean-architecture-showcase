import Observation

@MainActor
@Observable
final class MovieSearchViewModel {
    var query = ""
    var state: LoadableState<[MovieSearchResult]> = .idle

    private let searchMoviesUseCase: SearchMoviesUseCase

    init(searchMoviesUseCase: SearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }

    func search() async {
        state = .loading

        do {
            let movies = try await searchMoviesUseCase.execute(query: query)
            state = movies.isEmpty ? .empty("No movies found.") : .loaded(movies)
        } catch {
            state = .failed(Self.message(for: error))
        }
    }

    func retry() async {
        await search()
    }

    private static func message(for error: Error) -> String {
        guard let movieSearchError = error as? MovieSearchError else {
            return "Unable to search movies right now."
        }

        switch movieSearchError {
        case .emptyQuery:
            return "Enter a search term."
        case .noResults:
            return "No movies found for this search."
        case .invalidResponse:
            return "The API response used an unexpected format."
        case .requestFailed:
            return "Search failed. Check your connection and try again."
        }
    }
}
