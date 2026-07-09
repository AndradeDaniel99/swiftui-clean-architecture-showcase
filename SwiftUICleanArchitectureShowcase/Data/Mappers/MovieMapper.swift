import Foundation

enum MovieMapper {
    static func mapSearchResponse(_ dto: MovieSearchResponseDTO) throws -> [MovieSearchResult] {
        guard dto.response == "True" else {
            if dto.error == "Movie not found!" {
                throw MovieSearchError.noResults
            }

            throw MovieSearchError.requestFailed
        }

        return dto.search?.map(mapSearchResult) ?? []
    }

    static func mapSearchResult(_ dto: MovieSearchResultDTO) -> MovieSearchResult {
        MovieSearchResult(
            id: dto.imdbID,
            title: dto.title,
            year: dto.year,
            posterURL: posterURL(from: dto.poster)
        )
    }

    static func mapDetails(_ dto: MovieDetailsDTO) throws -> MovieDetails {
        guard dto.response == "True" else {
            throw MovieSearchError.requestFailed
        }

        return MovieDetails(
            id: dto.imdbID,
            title: dto.title,
            year: dto.year,
            runtime: dto.runtime,
            genre: dto.genre,
            director: dto.director,
            plot: dto.plot,
            posterURL: posterURL(from: dto.poster)
        )
    }

    private static func posterURL(from value: String) -> URL? {
        guard value != "N/A" else {
            return nil
        }

        return URL(string: value)
    }
}
