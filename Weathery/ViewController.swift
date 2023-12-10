import UIKit

class ViewController: UIViewController {
    let backgroundView: UIImageView = {
        $0.image = .background
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    let locationButton: UIButton = {
        $0.setImage(
            UIImage(systemName: "location.circle.fill"),
            for: []
        )
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

extension ViewController {
    private func setupViews() {
        [backgroundView,
         locationButton
        ].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            locationButton.widthAnchor.constraint(equalToConstant: 44),
            locationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

#Preview {
    ViewController()
}
