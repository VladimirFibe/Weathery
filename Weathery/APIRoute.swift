import Foundation

enum APIRoute {
    case getLocation(lat: Double, lon: Double)
    case getCity(city: String)
    
    var baseUrl: String {
        "https://api.openweathermap.org/data/2.5/weather"
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [.init(name: "appid", value: apiKey), .init(name: "units", value: "metric")]
        switch self {
        case .getLocation(let lat, let lon):
            items.append(contentsOf: [.init(name: "lat", value: "\(lat)"), .init(name: "lon", value: "\(lon)")])
        case .getCity(let city):
            items.append(.init(name: "q", value: city))
        }
        return items
    }
    
    var apiKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "APIKEY") as? String) ?? ""
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var request: URLRequest? {
        guard let url = URL(string: baseUrl),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        components.queryItems = queryItems
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
        return request
    }
}
