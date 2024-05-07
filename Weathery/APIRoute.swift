import Foundation

enum APIRoute {
    case getLocation(lat: Double, lon: Double)
    case getCity(city: String)
    var baseUrl: String {
        "https://api.openweathermap.org/data/2.5/weather"
    }
    
    var fullUrl: String {
        switch self {
        case .getLocation(let lat, let lon):
            return "\(baseUrl)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        case .getCity(city: let city):
            return "\(baseUrl)?appid=\(apiKey)&units=metric&q=\(city)"
        }
    }
    
    var apiKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "APIKEY") as? String) ?? ""
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var request: URLRequest? {
        guard let url = URL(string: fullUrl) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
}
