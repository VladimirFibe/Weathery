import Foundation

//MARK: - 1. Define an event.
// First, you define an event for something important that happens in your application. In our case, it’s when the weather comes in.
extension Notification.Name {
    static let didReceiveWeather = Notification.Name("didReceiveWeather")
}

struct WeatherNotificationService {
//MARK: - 3. Fire the event.
// When the event occurs in the app, we fire or post it like this.
    func fetchWeather(cityName: String) {
        let weatherModel = WeatherModel(conditionId: 200, cityName: cityName, temperature: -7)
        let data = ["currentWeather": weatherModel]
        NotificationCenter.default.post(name: .didReceiveWeather, object: self, userInfo: data)
    }
}

extension WeatheryViewController {
//MARK: - 3
    func fetchWithNotification() {
        let service = WeatherNotificationService()
        service.fetchWeather(cityName: "New York")
    }
//MARK: - 4. Get notified.
// Then whatever selector you specified when you registered for the event, that method gets called along with the notification that fired it. You can then take the information passed in as part of the userInfo dictionary, unwrap it, and use it to do whatever you want. In this case update our weather UI.
    @objc func didReceiveWeather(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: WeatherModel] else { return }
        guard let weather = data["currentWeather"] else { return }
        setupUI(with: weather)
    }

//MARK: - 2. Register observers.
// Then whoever wants to receive notification when that event occurs can register themselves for it.
    func setupReceiveWeather() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveWeather),
            name: .didReceiveWeather,
            object: nil
        )
    }
}
