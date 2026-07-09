import SwiftUI

struct MoviePosterView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    placeholder
                }
            } else {
                placeholder
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .accessibilityHidden(true)
    }

    private var placeholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.quaternary)

            Image(systemName: "film")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
    }
}
