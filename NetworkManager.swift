import Foundation

class NetworkManager<T: Codable> {
    private let url: URL
    
    private let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    init(url: URL) throws {
        self.url = url
    }

    func fetch() async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(customDateFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
