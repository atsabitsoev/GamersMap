import Foundation
import CoreLocation

struct ComputerClub: Codable {
    let id: Int
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let rating: Double
    let workingHours: String
    let phoneNumber: String
    let pricePerHour: Double
    let availableComputers: Int
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
} 