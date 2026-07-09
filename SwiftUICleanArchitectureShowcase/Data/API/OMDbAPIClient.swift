import Foundation

struct OMDbAPIClient: OMDbAPIClientProtocol {
    private let apiKey: String
    private let baseURL: URL
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    init(
        apiKey: String,
        baseURL: URL = URL(string: "https://www.omdbapi.com/")!,
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.decoder = decoder
    }

    func searchMovies(query: String) async throws -> MovieSearchResponseDTO {
        try await request(queryItems: [
            URLQueryItem(name: "s", value: query),
            URLQueryItem(name: "type", value: "movie")
        ])
    }

    func movieDetails(id: String) async throws -> MovieDetailsDTO {
        try await request(queryItems: [
            URLQueryItem(name: "i", value: id),
            URLQueryItem(name: "plot", value: "full")
        ])
    }

    private func request<Response: Decodable>(queryItems: [URLQueryItem]) async throws -> Response {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw MovieSearchError.invalidResponse
        }

        components.queryItems = queryItems + [URLQueryItem(name: "apikey", value: apiKey)]

        guard let url = components.url else {
            throw MovieSearchError.invalidResponse
        }

        do {
            let (data, response) = try await urlSession.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw MovieSearchError.requestFailed
            }

            return try decoder.decode(Response.self, from: data)
        } catch let error as MovieSearchError {
            throw error
        } catch {
            throw MovieSearchError.requestFailed
        }
    }
}
