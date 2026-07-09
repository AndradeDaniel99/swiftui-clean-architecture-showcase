import SwiftUI

struct LoadingView: View {
    let message: String

    var body: some View {
        ContentUnavailableView {
            ProgressView()
        } description: {
            Text(message)
        }
    }
}
