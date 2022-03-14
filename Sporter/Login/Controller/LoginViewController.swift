import UIKit

class LoginViewController: UIViewController {
    //
    // MARK: - Variables And Properties
    //
    var phone = String()
    var password = String()
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var loginTableView: UITableView!
    //
     // MARK: - View Controller
     //
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTableView.reloadData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       switch textField.tag {
        case 0:
            self.phone = textField.text ?? ""
           
        case 1:
            self.password = textField.text ?? ""
    
        default: break
        }
    }
 
    //
    // MARK: - Actions
    //
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        self.view.endEditing(true)
            if  phone == "" ||
                password == "" {
                        displayMessage(userMessage: "Заполните все поля")
                        self.view.activityStopAnimating()
                              return
               } else {
        LoginNetworkService.login(phone: phone, password: password, completion: { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
   
                if response.errorCode == "c0" {
                    guard let responseData = response.loginResponseBody else
            { return
            
            }
            
            let searchRequestData = SearchRequestData(authkey: responseData.authkey, id: responseData.id, sport: responseData.sportId, goals: responseData.goals, city: responseData.cityId, sex: 0)
            let userData = convertResponseDatatoUserData(responseData: responseData)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let myTabBar = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
            if let vc = myTabBar.viewControllers?[0] {
            if let nav = vc as? UINavigationController {

            if let profileViewController = nav.topViewController as? ProfileViewController {
            profileViewController.user = userData
                    }
                }
            }
 
            if let vc = myTabBar.viewControllers?[1] {
            if let nav1 = vc as? UINavigationController {
                if let searchViewController = nav1.topViewController as? SearchViewController {
            searchViewController.searchRequestData = searchRequestData
            searchViewController.user = userData
                        }
                    }
                }
           
                if let vc = myTabBar.viewControllers?[2] {
                    if let nav2 = vc as? UINavigationController {
                        if let dialogsViewController = nav2.topViewController as? DialogsViewController {
              dialogsViewController.user = userData
                        }
                    }
                }

            myTabBar.selectedIndex = 0
            myTabBar.modalPresentationStyle = .fullScreen
            self.present(myTabBar, animated: true, completion: nil)
            self.view.activityStopAnimating()
            self.view.endEditing(true)
            }
        } else {
            
            let errorDescription = ErrorHandler.errorHandler(errorCode: response.errorCode).errorDescription
         print(errorDescription)
                    if let errorAlert = ErrorHandler.errorHandler(errorCode: response.errorCode).errorAlert {
            self.displayMessage(userMessage: errorAlert)
                            }
                        }
                      })
                    }
                }
            }
//
// MARK: - Table View Delegate
//
extension LoginViewController: UITableViewDelegate {}
//
// MARK: - Table View Data Source
//
extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? PhoneNumberTableViewCell {
            cell1.phoneNumberTextField.text = ""
            cell1.phoneNumberTextField.delegate = self
            cell1.phoneNumberTextField.tag = 0
            
            cell1.selectionStyle = .none
            cell = cell1
            }
            return cell 
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? PasswordTableViewCell {
            cell.passwordTextField.text = ""
            cell.passwordTextField.delegate = self
            cell.passwordTextField.tag = 1
            cell.selectionStyle = .none
        }
            return cell
            }
        }
    }

//
// MARK: - Text Field Delegate
//
extension LoginViewController: UITextFieldDelegate {}
