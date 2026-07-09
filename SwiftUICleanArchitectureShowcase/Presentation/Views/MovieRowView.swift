import SwiftUI

struct MovieRowView: View {
    let movie: MovieSearchResult

    var body: some View {
        HStack(spacing: 12) {
            MoviePosterView(url: movie.posterURL)
                .frame(width: 56, height: 84)

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(movie.year)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
