import Foundation
import CoreLocation

protocol WeaterServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherDelegateService, weather: WeatherModel)
}
struct WeatherDelegateService {
    weak var delegate: WeaterServiceDelegate?
    
    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 700, cityName: cityName, temperature: -10)
        delegate?.didFetchWeather(self, weather: weatherModel)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let weatherModel = WeatherModel(conditionId: 800, cityName: "Paris", temperature: 25)
        delegate?.didFetchWeather(self, weather: weatherModel)
    }
}
