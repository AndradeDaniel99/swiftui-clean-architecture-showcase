import SwiftUI

@main
struct SwiftUICleanArchitectureShowcaseApp: App {
    private let appContainer = AppContainer.make()

    var body: some Scene {
        WindowGroup {
            MovieSearchView(
                viewModel: MovieSearchViewModel(
                    searchMoviesUseCase: appContainer.searchMoviesUseCase
                ),
                makeDetailViewModel: appContainer.makeMovieDetailViewModel
            )
        }
    }
}
