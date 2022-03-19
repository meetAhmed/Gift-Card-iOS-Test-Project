import UIKit
import SVProgressHUD

extension UIViewController {
    
    // extension to show alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // extension to show loading dialog
    func showLoader() {
        SVProgressHUD.show()
    }
    
    // extension to dismiss loading dialog
    func dismissLoader() {
        SVProgressHUD.dismiss()
    }
}

extension UIViewController {
    
    // extension to add custom back button for navigation controller
    // check if current view controller is not first then show icon on left side
    func navigationCustomBackButton() {
        guard let firstVC = navigationController?.viewControllers.first else { return }
        if firstVC == self {
            navigationItem.leftBarButtonItem = nil
        } else {
            addLeftBackButton()
        }
    }
    
    // function to add left bar item 
    func addLeftBackButton() {
        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(navigationController, action: #selector(UINavigationController.popViewController(animated:)), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
    }
}
