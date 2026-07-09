import XCTest
@testable import SwiftUICleanArchitectureShowcase

final class GetMovieDetailsUseCaseTests: XCTestCase {
    func testExecuteReturnsMovieDetailsFromRepository() async throws {
        let expectedDetails = MovieDetails(
            id: "tt0133093",
            title: "The Matrix",
            year: "1999",
            runtime: "136 min",
            genre: "Action, Sci-Fi",
            director: "Lana Wachowski, Lilly Wachowski",
            plot: "A hacker learns about the nature of his reality.",
            posterURL: nil
        )
        let repository = FakeMovieRepository()
        repository.detailsResult = .success(expectedDetails)
        let useCase = GetMovieDetailsUseCase(repository: repository)

        let details = try await useCase.execute(id: "tt0133093")

        XCTAssertEqual(details, expectedDetails)
    }
}
