protocol OMDbAPIClientProtocol: Sendable {
    func searchMovies(query: String) async throws -> MovieSearchResponseDTO
    func movieDetails(id: String) async throws -> MovieDetailsDTO
}
