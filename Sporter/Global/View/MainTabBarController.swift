import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
 
            if(item.tag == 1) {
                 // Code for item 1
             } else if(item.tag == 2) {
               
             }
    }
     
    override func viewDidLoad() {
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller", viewController)
        print("index", tabBarController.selectedIndex )
        
        if tabBarController.selectedIndex == 2 {
            
        }
   }
}
