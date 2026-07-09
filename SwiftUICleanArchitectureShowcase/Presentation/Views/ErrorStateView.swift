import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Erro", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Tentar novamente", systemImage: "arrow.clockwise", action: retry)
                .buttonStyle(.borderedProminent)
        }
    }
}
