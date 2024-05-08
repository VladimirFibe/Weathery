import Foundation
import CoreLocation

protocol WeaterServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherDelegateService, weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherDelegateService, error: APIError)
}
struct WeatherDelegateService {
    weak var delegate: WeaterServiceDelegate?
    
    func fetchWeather(cityName: String) {
        guard let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            delegate?.didFailWithError(self, error: .general(reason: "Could not encode city named: \(cityName)"))
            return
        }
        request(.getCity(city: city))
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        request(.getLocation(lat: latitude, lon: longitude))
    }
    
    func request(_ route: APIRoute) {
        guard let request = route.request else { return }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, error: .general(reason: error.localizedDescription))
                }
                return
            }
            guard let data, let httpResponse = response as? HTTPURLResponse else {
                
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, error: .httpResponse(code: httpResponse.statusCode))
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let decodedData = try? decoder.decode(WeatherData.self, from: data) 
            else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, error: .failedTogetData)
                }
                return
            }
            let weather = WeatherModel(
                conditionId: decodedData.weather[0].id,
                cityName: decodedData.name,
                temperature: decodedData.main.temp
            )
            DispatchQueue.main.async {
                self.delegate?.didFetchWeather(self, weather: weather)
            }
        }
        task.resume()
    }
}
