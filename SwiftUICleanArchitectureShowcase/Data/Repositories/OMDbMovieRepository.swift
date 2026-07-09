struct OMDbMovieRepository: MovieRepository {
    private let apiClient: OMDbAPIClientProtocol

    init(apiClient: OMDbAPIClientProtocol) {
        self.apiClient = apiClient
    }

    func searchMovies(query: String) async throws -> [MovieSearchResult] {
        let response = try await apiClient.searchMovies(query: query)
        return try MovieMapper.mapSearchResponse(response)
    }

    func movieDetails(id: String) async throws -> MovieDetails {
        let response = try await apiClient.movieDetails(id: id)
        return try MovieMapper.mapDetails(response)
    }
}
