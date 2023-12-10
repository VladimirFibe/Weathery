import Foundation

struct WeatherClosureService {
    var receivedWeatherHandler: ((WeatherModel) -> Void)?

    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 200, cityName: cityName, temperature: 7.0)
        receivedWeatherHandler?(weatherModel)
    }
}

extension WeatherViewController {
    func fetchWithClosure() {
        var service = WeatherClosureService()
        service.receivedWeatherHandler = setupUI
        service.fetchWeather(cityName: "London")
    }
}
