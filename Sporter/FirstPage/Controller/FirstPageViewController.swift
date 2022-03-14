import UIKit

class FirstPageViewController: UIViewController {

    //
    // MARK: - Outlets
    //
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    //
    // MARK: - View Controller
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loginButton.layer.cornerRadius = 25
        registrationButton.layer.cornerRadius = 25
        registrationButton.layer.borderWidth = 1
        registrationButton.layer.borderColor = UIColor.blue.cgColor
        registrationButton.setTitleColor(UIColor.blue, for: .normal)

    }
    
    //
    // MARK: - Actions
    //
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
               
               self.show(editProfileViewController, sender: self)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                  
        self.show(editProfileViewController, sender: self)
        }
    }
}
