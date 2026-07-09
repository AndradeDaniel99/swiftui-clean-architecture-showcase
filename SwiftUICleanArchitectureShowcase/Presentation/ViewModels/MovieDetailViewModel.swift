import Observation

@MainActor
@Observable
final class MovieDetailViewModel {
    let movie: MovieSearchResult
    var state: LoadableState<MovieDetails> = .idle

    private let getMovieDetailsUseCase: GetMovieDetailsUseCase

    init(movie: MovieSearchResult, getMovieDetailsUseCase: GetMovieDetailsUseCase) {
        self.movie = movie
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func loadDetails() async {
        state = .loading

        do {
            state = .loaded(try await getMovieDetailsUseCase.execute(id: movie.id))
        } catch {
            state = .failed("Nao foi possivel carregar os detalhes do filme.")
        }
    }
}
