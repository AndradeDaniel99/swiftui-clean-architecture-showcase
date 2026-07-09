struct MovieDetailsDTO: Decodable, Sendable {
    let title: String
    let year: String
    let runtime: String
    let genre: String
    let director: String
    let plot: String
    let poster: String
    let imdbID: String
    let response: String
    let error: String?

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case plot = "Plot"
        case poster = "Poster"
        case imdbID
        case response = "Response"
        case error = "Error"
    }
}
