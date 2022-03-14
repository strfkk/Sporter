

import UIKit

class FillAccountViewController: UIViewController {

    @IBOutlet weak var fillAccountTableView: UITableView!

    //
    // MARK: - Variables And Properties
    //
    var id = Int()
    var authkey = String()
    var age = Int()
    
    var sportIndexPath: IndexPath?
    var goalIndexPath: IndexPath?
    var cityIndexPath: IndexPath?
    
    var cityIndexForRequest = Int()
    var sportIndexForRequest = Int()
    var goalIndexForRequest = Int()
    
    var phoneNumber = String()
    var password = String()
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillAccountTableView.reloadData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    //
    // MARK: - Actions
    //
    @IBAction func nextButtonTapped(_ sender: Any) {
         self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))

        if cityIndexPath == nil || sportIndexPath == nil || goalIndexPath == nil {
            displayMessage(userMessage: "Выберите все поля")
            self.view.activityStopAnimating()
        } else {
            switch cityIndexPath?.row {
            case 0: cityIndexForRequest = 3
            case 1: cityIndexForRequest = 4
            default:
                print("casting error")
            }
            
            switch sportIndexPath?.row {
                       case 0: sportIndexForRequest = 2
                       case 1: sportIndexForRequest = 3
                       case 2: sportIndexForRequest = 1
                       case 3: sportIndexForRequest = 4
                       default:
                           print("casting error")
                       }
            switch goalIndexPath?.row {
            case 0: goalIndexForRequest = 5
            case 1: goalIndexForRequest = 11
            case 2: goalIndexForRequest = 2
            case 3: goalIndexForRequest = 3
            default:
                print("casting error")
            }
        }
        
        FillAccountNetworkingService.fillAccount(age: age, sportId: String(sportIndexForRequest), goalId: String(goalIndexForRequest), cityId: String(cityIndexForRequest), userId: String(id), authkey: authkey) { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
            if response.errorCode == "c0" {
                LoginNetworkService.login(phone: self.phoneNumber, password: self.password) { (response) in
        
                    if let response = response {
                    
                    guard let responseData = response.loginResponseBody else
                    { return }

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
                        if let nav2  = vc as? UINavigationController {
                            if let dialogsViewController = nav2.topViewController as? DialogsViewController {
                      dialogsViewController.user = userData
                            }
                        }
                        
                    myTabBar.selectedIndex = 0
                            myTabBar.modalPresentationStyle = .fullScreen
                    self.present(myTabBar, animated: true, completion: nil)
                    self.view.activityStopAnimating()
                    self.view.endEditing(true)
                                }
                            }
                        }
                    }
                } else {
                    let errorDescription = ErrorHandler.errorHandler(errorCode: response.errorCode).errorDescription
                    
                     print(errorDescription)
                    
                    if let errorAlert = ErrorHandler.errorHandler(errorCode: response.errorCode).errorAlert {
                        self.displayMessage(userMessage: errorAlert)
                            }
                        }
                    }
                }
            }
//
// MARK: - Table View Delegate
//
extension FillAccountViewController: UITableViewDelegate {}
//
// MARK: - Table View Data Source
//
extension FillAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = Int()
        
        switch section {
        case 0: numberOfRows = 2
        case 1: numberOfRows = 4
        case 2: numberOfRows = 4
        default:
            numberOfRows = 0
        }
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = String()
               
        switch section {
        case 0: title = "Выберите город"
        case 1: title = "Выберите вид спорта, в котором вы хотели бы найти себе компанию "
        case 2: title = "Выберите кого вы хотели бы найти"
        default:
                  title = ""
               }
               return title
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.section {
        case 0: cell.textLabel?.text = cities[indexPath.row]
        case 1: cell.textLabel?.text = sports[indexPath.row]
        case 2: cell.textLabel?.text = goals[indexPath.row]
            
        default: print("")
        }
        cell.selectionStyle = .none
            return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let cityIndexPath = cityIndexPath {
            tableView.cellForRow(at:cityIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            cityIndexPath = indexPath
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
       case 1:
       if let sportIndexPath = sportIndexPath {
           tableView.cellForRow(at:sportIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
       }
           sportIndexPath = indexPath
           tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        case 2:
        if let goalIndexPath = goalIndexPath {
            tableView.cellForRow(at:goalIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
            goalIndexPath = indexPath
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        default:
            print("")
            }
        }
    }
