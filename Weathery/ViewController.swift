import UIKit

class ViewController: UIViewController {
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
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

extension ViewController {
    private func setupViews() {
        [backgroundView,
         searchStackView
        ].forEach {
            view.addSubview($0)
        }
        [locationButton, searchTextField, searchButton].forEach {
            searchStackView.addArrangedSubview($0)
        }
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

            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 1)

        ])
    }
}

#Preview {
    ViewController()
}
