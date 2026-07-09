import XCTest
@testable import SwiftUICleanArchitectureShowcase

@MainActor
final class MovieDetailViewModelTests: XCTestCase {
    func testLoadDetailsSetsLoadedState() async {
        let movie = MovieSearchResult(id: "tt0133093", title: "The Matrix", year: "1999", posterURL: nil)
        let details = MovieDetails(
            id: movie.id,
            title: movie.title,
            year: movie.year,
            runtime: "136 min",
            genre: "Action, Sci-Fi",
            director: "Lana Wachowski, Lilly Wachowski",
            plot: "A hacker learns about the nature of his reality.",
            posterURL: nil
        )
        let repository = FakeMovieRepository()
        repository.detailsResult = .success(details)
        let viewModel = MovieDetailViewModel(
            movie: movie,
            getMovieDetailsUseCase: GetMovieDetailsUseCase(repository: repository)
        )

        await viewModel.loadDetails()

        XCTAssertEqual(viewModel.state, .loaded(details))
    }
}
