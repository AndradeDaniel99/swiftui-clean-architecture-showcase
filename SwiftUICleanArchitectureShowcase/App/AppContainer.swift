import Foundation

@MainActor
struct AppContainer {
    let searchMoviesUseCase: SearchMoviesUseCase
    let makeMovieDetailViewModel: @MainActor (MovieSearchResult) -> MovieDetailViewModel

    static func make(environment: [String: String] = ProcessInfo.processInfo.environment) -> AppContainer {
        let repository: MovieRepository

        if let apiKey = environment["OMDB_API_KEY"], apiKey.isEmpty == false {
            repository = OMDbMovieRepository(apiClient: OMDbAPIClient(apiKey: apiKey))
        } else {
            repository = PreviewMovieRepository()
        }

        return AppContainer(
            searchMoviesUseCase: SearchMoviesUseCase(repository: repository),
            makeMovieDetailViewModel: { movie in
                MovieDetailViewModel(
                    movie: movie,
                    getMovieDetailsUseCase: GetMovieDetailsUseCase(repository: repository)
                )
            }
        )
    }
}
