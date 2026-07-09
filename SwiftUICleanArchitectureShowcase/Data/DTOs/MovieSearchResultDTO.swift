struct MovieSearchResultDTO: Decodable, Sendable {
    let title: String
    let year: String
    let imdbID: String
    let poster: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}
