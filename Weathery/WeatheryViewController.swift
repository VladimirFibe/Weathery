import UIKit
import CoreLocation

class WeatheryViewController: UIViewController {
    let locationManager = CLLocationManager()
    var weatherService = WeatherDelegateService()
    
    private let backgroundView: UIImageView = {
        $0.image = .background
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private let locationButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: [])
        return $0
    }(UIButton())

    private let searchButton: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: [])
        return $0
    }(UIButton())

    private let searchTextField: UITextField = {
        $0.placeholder = "Search"
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.borderStyle = .roundedRect
        $0.textAlignment = .right
        $0.backgroundColor = .systemFill
        return $0
    }(UITextField())

    private let searchStackView: UIStackView = {
        $0.spacing = 10
        return $0
    }(UIStackView())

    private let conditionImageView: UIImageView = {
        $0.image = UIImage(systemName: "sun.max")
        return $0
    }(UIImageView())

    private let temperatureLabel: UILabel = {
        $0.font = .systemFont(ofSize: 80)
        return $0
    }(UILabel())

    private let cityLabel: UILabel = {
        $0.text = "Almaty"
        $0.font = .preferredFont(forTextStyle: .largeTitle)
        return $0
    }(UILabel())

    private let rootStackView: UIStackView = {
        $0.alignment = .trailing
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

extension WeatheryViewController {
    private func setupViews() {
        temperatureLabel.attributedText = makeTemperatureText(with: "22")
        [backgroundView,
         rootStackView
        ].forEach {
            view.addSubview($0)
        }
        [locationButton, searchTextField, searchButton].forEach {
            searchStackView.addArrangedSubview($0)
        }
        [searchStackView, conditionImageView, temperatureLabel, cityLabel].forEach {
            rootStackView.addArrangedSubview($0)
        }
        searchButton.addTarget(self, action: #selector(searchPressed), for: .primaryActionTriggered)
        locationButton.addTarget(self, action: #selector(locationPressed), for: .primaryActionTriggered)
        searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherService.delegate = self
//        setupReceiveWeather()
    }

    func setupUI(with weather: WeatherModel) {
        temperatureLabel.attributedText = makeTemperatureText(with: weather.temperatureString)
        conditionImageView.image = UIImage(systemName: weather.conditionName)
        cityLabel.text = weather.cityName
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),

            conditionImageView.widthAnchor.constraint(equalToConstant: 120),
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),
            
            searchStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor),
            searchStackView.heightAnchor.constraint(equalToConstant: 44),
            
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1)

        ])
    }

    private func makeTemperatureText(with temperature: String) -> NSAttributedString {
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)

        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.systemFont(ofSize: 80)

        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "ºC", attributes: plainTextAttributes))

        return text
    }

    @objc func searchPressed() {
        searchTextField.endEditing(true)
//        fetchWithNotification()
//        fetchWithClosure()
    }
}
//MARK: - UITextFieldDelegate
extension WeatheryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Type something"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherService.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}
//MARK: - CLLocationManagerDelegate
extension WeatheryViewController: CLLocationManagerDelegate {
    @objc func locationPressed() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherService.fetchWeather(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
//MARK: - WeaterServiceDelegate
extension WeatheryViewController: WeaterServiceDelegate {
    func didFailWithError(_ weatherService: WeatherDelegateService, error: APIError) {
        let message: String
        switch error {
        case .httpResponse(code: let code):
            message = "Network error. Status code: \(code)"
        case .general(reason: let text):
            message = text
        default:
            message = "Error"
        }
        showErrorAlert(with: message)
    }
    
    func didFetchWeather(_ weatherService: WeatherDelegateService, weather: WeatherModel) {
        setupUI(with: weather)
    }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error fetching weather", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

#Preview {
    WeatheryViewController()
}
