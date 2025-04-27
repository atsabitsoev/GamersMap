import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 0)
        
        let listVC = ClubListViewController()
        listVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        viewControllers = [
            UINavigationController(rootViewController: mapVC),
            UINavigationController(rootViewController: listVC)
        ]
    }
} 