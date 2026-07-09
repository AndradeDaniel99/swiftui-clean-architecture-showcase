import SwiftUI

struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MoviePosterView(url: viewModel.movie.posterURL)
                    .frame(maxWidth: .infinity)

                content
            }
            .padding()
        }
        .navigationTitle(viewModel.movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if viewModel.state == .idle {
                await viewModel.loadDetails()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            LoadingView(message: "Carregando detalhes...")
        case let .loaded(details):
            MovieDetailsContentView(details: details)
        case let .empty(message):
            EmptyStateView(title: "Detalhes indisponiveis", message: message)
        case let .failed(message):
            ErrorStateView(message: message) {
                Task {
                    await viewModel.loadDetails()
                }
            }
        }
    }
}
