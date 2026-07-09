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
            state = movies.isEmpty ? .empty("Nenhum filme encontrado.") : .loaded(movies)
        } catch {
            state = .failed(Self.message(for: error))
        }
    }

    func retry() async {
        await search()
    }

    private static func message(for error: Error) -> String {
        guard let movieSearchError = error as? MovieSearchError else {
            return "Nao foi possivel buscar filmes agora."
        }

        switch movieSearchError {
        case .emptyQuery:
            return "Digite um termo para buscar filmes."
        case .noResults:
            return "Nenhum filme encontrado para essa busca."
        case .invalidResponse:
            return "A resposta da API veio em um formato inesperado."
        case .requestFailed:
            return "A busca falhou. Verifique sua conexao e tente novamente."
        }
    }
}
