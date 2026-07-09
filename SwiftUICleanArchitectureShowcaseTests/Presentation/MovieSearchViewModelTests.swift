import XCTest
@testable import SwiftUICleanArchitectureShowcase

@MainActor
final class MovieSearchViewModelTests: XCTestCase {
    func testSearchSetsLoadedStateWhenMoviesAreReturned() async {
        let movie = MovieSearchResult(id: "tt0133093", title: "The Matrix", year: "1999", posterURL: nil)
        let repository = FakeMovieRepository()
        repository.searchResult = .success([movie])
        let viewModel = MovieSearchViewModel(
            searchMoviesUseCase: SearchMoviesUseCase(repository: repository)
        )
        viewModel.query = "matrix"

        await viewModel.search()

        XCTAssertEqual(viewModel.state, .loaded([movie]))
    }

    func testSearchSetsFailureStateWhenRepositoryFails() async {
        let repository = FakeMovieRepository()
        repository.searchResult = .failure(MovieSearchError.requestFailed)
        let viewModel = MovieSearchViewModel(
            searchMoviesUseCase: SearchMoviesUseCase(repository: repository)
        )
        viewModel.query = "matrix"

        await viewModel.search()

        XCTAssertEqual(viewModel.state, .failed("Search failed. Check your connection and try again."))
    }

    func testSearchSetsFailureStateWhenQueryIsEmpty() async {
        let repository = FakeMovieRepository()
        let viewModel = MovieSearchViewModel(
            searchMoviesUseCase: SearchMoviesUseCase(repository: repository)
        )

        await viewModel.search()

        XCTAssertEqual(viewModel.state, .failed("Enter a search term."))
    }
}
