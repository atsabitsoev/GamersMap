import UIKit
import MapKit

class MapViewController: UIViewController {
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Поиск компьютерных клубов"
        return searchBar
    }()
    
    private var clubs: [ComputerClub] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        loadMockData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "GamersMap"
        
        view.addSubview(searchBar)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // Установка начальной области карты (Москва)
        let initialLocation = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    private func loadMockData() {
        // Временные данные для демонстрации
        clubs = [
            ComputerClub(id: 1, name: "Cyber Club", address: "ул. Примерная, 1", latitude: 55.7558, longitude: 37.6173, rating: 4.5, workingHours: "24/7", phoneNumber: "+7 (999) 123-45-67", pricePerHour: 200, availableComputers: 20),
            ComputerClub(id: 2, name: "Gaming Zone", address: "пр. Тестовый, 2", latitude: 55.7517, longitude: 37.6178, rating: 4.2, workingHours: "10:00-22:00", phoneNumber: "+7 (999) 765-43-21", pricePerHour: 180, availableComputers: 15)
        ]
        
        addAnnotations()
    }
    
    private func addAnnotations() {
        for club in clubs {
            let annotation = MKPointAnnotation()
            annotation.coordinate = club.coordinate
            annotation.title = club.name
            annotation.subtitle = club.address
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "ClubAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let detailButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = detailButton
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        
        // Здесь будет переход к детальной информации о клубе
        let alert = UIAlertController(title: annotation.title ?? "", message: annotation.subtitle ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
} 