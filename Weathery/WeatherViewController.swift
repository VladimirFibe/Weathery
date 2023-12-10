import UIKit

class WeatherViewController: UIViewController {
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

extension WeatherViewController {
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
        setupReceiveWeather()
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

            locationButton.widthAnchor.constraint(equalToConstant: 44),
            locationButton.heightAnchor.constraint(equalToConstant: 44),

            searchButton.widthAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalToConstant: 44),

            conditionImageView.widthAnchor.constraint(equalToConstant: 120),
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),
            searchStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor),
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
}



#Preview {
    WeatherViewController()
}
