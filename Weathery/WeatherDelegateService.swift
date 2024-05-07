import Foundation
import CoreLocation

protocol WeaterServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherDelegateService, weather: WeatherModel)
}
struct WeatherDelegateService {
    weak var delegate: WeaterServiceDelegate?
    
    func fetchWeather(cityName: String) {
        Task {
            do {
                let response: WeatherResponse = try await APIClient.shared.request(.getCity(city: cityName))
                let weatherModel = WeatherModel(conditionId: 800, cityName: response.name, temperature: response.main.temp)
                DispatchQueue.main.async {
                    delegate?.didFetchWeather(self, weather: weatherModel)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        Task {
            do {
                let response: WeatherResponse = try await APIClient.shared.request(.getLocation(lat: latitude, lon: longitude))
                let weatherModel = WeatherModel(conditionId: 800, cityName: response.name, temperature: response.main.temp)
                DispatchQueue.main.async {
                    delegate?.didFetchWeather(self, weather: weatherModel)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
