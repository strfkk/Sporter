import UIKit

class RegisterViewController: UIViewController {
    //
    // MARK: - Variables And Properties
    //
    var name = String()
    var phone = String()
    var password = String()
    var age = String()
    var id = Int()
    var authkey = String()
    var ageInt = Int()
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var registerTableView: UITableView!
    //
    // MARK: - View Controller
    //
    func textFieldDidEndEditing(_ textField: UITextField) {
       switch textField.tag {
        case 0:
            self.name = textField.text ?? ""
           // textField.text = ""
        case 1:
            self.age = textField.text ?? ""
        case 2:
            self.phone = textField.text ?? ""
        case 3:
            self.password = textField.text ?? ""
        default: break
        }
    }
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.registerTableView.reloadData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
       
    }
   
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
      self.view.endEditing(true)
        if name == "" ||
            age == "" ||
          phone == "" ||
       password == "" {
            displayMessage(userMessage: "Заполните все поля")
            self.view.activityStopAnimating()
            return
        } else {
            RegisterNetworkingService.newUser(phone: phone, name: name, password: password) { [self] (response) in
                guard let response = response else {
                    self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                    return }
                if response.errorCode == "c0" {
                    
                if let id = response.newUserResponseBody?.id {
                    self.id = id
                }
                if let authkey = response.newUserResponseBody?.authkey {
                    self.authkey = authkey
                }
                    self.ageInt = Int(age) ?? 0
            
                
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                if let fillAccountViewController = storyBoard.instantiateViewController(withIdentifier: "FillAccountViewController") as? FillAccountViewController {
                
            fillAccountViewController.id = self.id
            fillAccountViewController.authkey = self.authkey
            fillAccountViewController.age = self.ageInt
            fillAccountViewController.phoneNumber = phone
            fillAccountViewController.password = password
            
            self.show(fillAccountViewController, sender: self)
                } else {
                     print("fill account error")
                }
            self.view.activityStopAnimating()
                }  else {
                    let errorDescription = ErrorHandler.errorHandler(errorCode: response.errorCode).errorDescription
                    
                     print(errorDescription)
                    
                    if let errorAlert = ErrorHandler.errorHandler(errorCode: response.errorCode).errorAlert {
                        displayMessage(userMessage: errorAlert)
                   
                    }
                }
            }
        }
    }
}
//
// MARK: - Table View Delegate
//
extension RegisterViewController: UITableViewDelegate {}
//
// MARK: - Table View Data Source
//
extension RegisterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewUserTableViewCell
                cell.inputTextField.text = ""
                cell.inputTextField.delegate = self
                cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0: cell.inputTextField.tag = 0
                cell.inputTextField.placeholder = "Введите ваше имя"
        case 1: cell.inputTextField.tag = 1
                       cell.inputTextField.placeholder = "Введите ваш возраст"
            cell.inputTextField.keyboardType = .phonePad
        case 2: cell.inputTextField.tag = 2
                cell.inputTextField.placeholder = "Введите ваш номер телефона"
                cell.inputTextField.keyboardType = .phonePad
            
        case 3: cell.inputTextField.tag = 3
                cell.inputTextField.placeholder = "Введите пароль"
        cell.inputTextField.isSecureTextEntry = true
        default:
            print("")
        }
            return cell
    }
}
//
// MARK: - Text Field Delegate
//
extension RegisterViewController: UITextFieldDelegate {}

