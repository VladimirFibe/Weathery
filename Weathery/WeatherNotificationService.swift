import Foundation

struct WeatherNotificationService {
    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 200, cityName: cityName, temperature: -7)
        let data = ["currentWeather": weatherModel]
        NotificationCenter.default.post(name: .didReceiveWeather, object: self, userInfo: data)
    }
}
