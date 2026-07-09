struct GetMovieDetailsUseCase: Sendable {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(id: String) async throws -> MovieDetails {
        try await repository.movieDetails(id: id)
    }
}
