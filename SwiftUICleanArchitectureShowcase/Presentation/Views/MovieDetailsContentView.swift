import SwiftUI

struct MovieDetailsContentView: View {
    let details: MovieDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(details.title)
                .font(.title)
                .fontWeight(.semibold)

            Text("\(details.year) • \(details.runtime)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            DetailLineView(title: "Genero", value: details.genre)
            DetailLineView(title: "Direcao", value: details.director)

            Text(details.plot)
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
