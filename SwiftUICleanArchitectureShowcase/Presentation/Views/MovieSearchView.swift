import SwiftUI

struct MovieSearchView: View {
    @State var viewModel: MovieSearchViewModel

    let makeDetailViewModel: (MovieSearchResult) -> MovieDetailViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                searchField
                content
            }
            .padding()
            .navigationTitle("Movie Search")
        }
    }

    private var searchField: some View {
        HStack(spacing: 8) {
            TextField("Search movies", text: $viewModel.query)
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .onSubmit {
                    Task {
                        await viewModel.search()
                    }
                }

            Button("Search", systemImage: "magnifyingglass") {
                Task {
                    await viewModel.search()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyStateView(title: "Search for a movie", message: "Enter a title to get started.")
        case .loading:
            LoadingView(message: "Searching movies...")
        case let .loaded(movies):
            List(movies) { movie in
                NavigationLink {
                    MovieDetailView(viewModel: makeDetailViewModel(movie))
                } label: {
                    MovieRowView(movie: movie)
                }
            }
            .listStyle(.plain)
        case let .empty(message):
            EmptyStateView(title: "No results", message: message)
        case let .failed(message):
            ErrorStateView(message: message) {
                Task {
                    await viewModel.retry()
                }
            }
        }
    }
}
