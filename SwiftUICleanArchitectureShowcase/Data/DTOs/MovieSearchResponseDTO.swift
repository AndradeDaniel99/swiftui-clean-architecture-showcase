struct MovieSearchResponseDTO: Decodable, Sendable {
    let search: [MovieSearchResultDTO]?
    let response: String
    let error: String?

    private enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
        case error = "Error"
    }
}
