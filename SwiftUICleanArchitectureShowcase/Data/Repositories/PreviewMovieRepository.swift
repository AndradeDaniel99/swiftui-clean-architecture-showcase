struct PreviewMovieRepository: MovieRepository {
    private let movies = [
        MovieSearchResult(id: "tt0133093", title: "The Matrix", year: "1999", posterURL: nil),
        MovieSearchResult(id: "tt0234215", title: "The Matrix Reloaded", year: "2003", posterURL: nil),
        MovieSearchResult(id: "tt0242653", title: "The Matrix Revolutions", year: "2003", posterURL: nil)
    ]

    func searchMovies(query: String) async throws -> [MovieSearchResult] {
        let results = movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(query)
        }

        if results.isEmpty {
            throw MovieSearchError.noResults
        }

        return results
    }

    func movieDetails(id: String) async throws -> MovieDetails {
        guard let movie = movies.first(where: { $0.id == id }) else {
            throw MovieSearchError.noResults
        }

        return MovieDetails(
            id: movie.id,
            title: movie.title,
            year: movie.year,
            runtime: "136 min",
            genre: "Action, Sci-Fi",
            director: "Lana Wachowski, Lilly Wachowski",
            plot: "A programmer discovers that his world is a simulated reality and joins a group fighting to free humanity.",
            posterURL: movie.posterURL
        )
    }
}
