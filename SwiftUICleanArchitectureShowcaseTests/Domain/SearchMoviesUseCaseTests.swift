import XCTest
@testable import SwiftUICleanArchitectureShowcase

final class SearchMoviesUseCaseTests: XCTestCase {
    func testExecuteTrimsQueryBeforeCallingRepository() async throws {
        let repository = FakeMovieRepository()
        repository.searchResult = .success([
            MovieSearchResult(id: "tt0133093", title: "The Matrix", year: "1999", posterURL: nil)
        ])
        let useCase = SearchMoviesUseCase(repository: repository)

        let movies = try await useCase.execute(query: "  matrix  ")

        XCTAssertEqual(repository.lastSearchQuery, "matrix")
        XCTAssertEqual(movies.count, 1)
    }

    func testExecuteThrowsEmptyQueryWhenQueryHasOnlySpaces() async {
        let repository = FakeMovieRepository()
        let useCase = SearchMoviesUseCase(repository: repository)

        do {
            _ = try await useCase.execute(query: "   ")
            XCTFail("Expected empty query error.")
        } catch {
            XCTAssertEqual(error as? MovieSearchError, .emptyQuery)
        }
    }
}
