import UIKit

class ClubListViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ClubTableViewCell.self, forCellReuseIdentifier: "ClubCell")
        return table
    }()
    
    private var clubs: [ComputerClub] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMockData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Компьютерные клубы"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadMockData() {
        // Временные данные для демонстрации
        clubs = [
            ComputerClub(id: 1, name: "Cyber Club", address: "ул. Примерная, 1", latitude: 55.7558, longitude: 37.6173, rating: 4.5, workingHours: "24/7", phoneNumber: "+7 (999) 123-45-67", pricePerHour: 200, availableComputers: 20),
            ComputerClub(id: 2, name: "Gaming Zone", address: "пр. Тестовый, 2", latitude: 55.7517, longitude: 37.6178, rating: 4.2, workingHours: "10:00-22:00", phoneNumber: "+7 (999) 765-43-21", pricePerHour: 180, availableComputers: 15)
        ]
        
        tableView.reloadData()
    }
}

extension ClubListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? ClubTableViewCell else {
            return UITableViewCell()
        }
        
        let club = clubs[indexPath.row]
        cell.configure(with: club)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let club = clubs[indexPath.row]
        // Здесь будет переход к детальной информации о клубе
        let alert = UIAlertController(title: club.name, message: "Адрес: \(club.address)\nТелефон: \(club.phoneNumber)\nЦена: \(club.pricePerHour) ₽/час", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
} 