import Foundation

extension Notification.Name {
    static let didReceiveWeather = Notification.Name("didReceiveWeather")
}

struct WeatherNotificationService {
    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 200, cityName: cityName, temperature: -7)
        let data = ["currentWeather": weatherModel]
        NotificationCenter.default.post(name: .didReceiveWeather, object: self, userInfo: data)
    }
}

extension WeatherViewController {
    @objc func searchPressed() {
        let service = WeatherNotificationService()
        service.fetchWeather(cityName: "New York")
    }

    @objc func didReceiveWeather(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: WeatherModel] else { return }
        guard let weather = data["currentWeather"] else { return }
        setupUI(with: weather)
    }

    func setupReceiveWeather() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveWeather),
            name: .didReceiveWeather,
            object: nil
        )
    }
}
