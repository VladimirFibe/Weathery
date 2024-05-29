import UIKit

class WeatherViewController: UIViewController {
    private let backgroundImageView = UIImageView()
    private let cityStackView = UIStackView()
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImageView()
        setupCityStackView()
        setupCityLabel()
        setupTemperatureLabel()
    }

    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.image = .background
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCityStackView() {
        view.addSubview(cityStackView)
        cityStackView.axis = .vertical
        cityStackView.spacing = 0
        cityStackView.alignment = .center
        cityStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 51),
            cityStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupCityLabel() {
        cityStackView.addArrangedSubview(cityLabel)
        cityLabel.text = "Montreal"
        cityLabel.font = .systemFont(ofSize: 34)
    }

    private func setupTemperatureLabel() {
        cityStackView.addArrangedSubview(temperatureLabel)
        temperatureLabel.text = "19°"
        temperatureLabel.font = .systemFont(ofSize: 96, weight: .thin)
    }
}

@available (iOS 17.0, *)

#Preview {
    WeatherViewController()
}
