import UIKit

class ProfileViewController: UIViewController, EditProfileViewControllerDelegate {

    //
    // MARK: - Variables And Properties
    //
    var shouldHideSection = true
    var user: UserData?
    var isPhotoEdited: Bool = false
    var avatarImage = UIImage(named: "111")

    var cell3Data = [
                ("Ищу","Не заполнено"),
                ("Спорт","Не заполнено"),
                ("Возраст","Не заполнено")
            ]
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    //
    // MARK: - View Controller
    //
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage1(from url: URL) {
        print("Download Started")
       
    }
    func updateUserData(userData: UserData1, avatar: UIImage) {
        self.user?.city = userData.city
        self.user?.sport = userData.sport
        self.user?.goals = userData.goals
        self.user?.age = userData.age
        self.user?.city = userData.city
         self.user?.about = userData.about
        
        self.avatarImage = avatar

        cell3Data = [
            ("Ищу","\(userData.goals)"),
            ("Спорт","\(userData.sport)"),
            ("Возраст","\(userData.age)")
                 ]
        
        self.tableView.reloadData()
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView?.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.layer.cornerRadius = 5
        
        self.tableView.separatorStyle = .none
        if let user = user {
          cell3Data = [
            ("Ищу","\(user.goals)"),
             ("Спорт","\(user.sport)"),
             ("Возраст","\(user.age)")
                   ]
        }
        
        var id = Int()
        var userId = Int()
        var authkey = String()
        if let user = user {
            id = user.id
            userId = user.id
            authkey = user.authkey
        }
    
        if let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(userId)&authkey=\(authkey)&id=\(id)") {

        if let data = NetworkingService.shared.downloadImage(from: url, id: userId) {
        DispatchQueue.main.async() { [weak self] in
            if UIImage(data: data) != nil {
                self?.isPhotoEdited = true
                              self?.tableView.reloadData()
                            }
                        }
                    }
                }
       
        self.view.endEditing(true)
    }
    
    //
    // MARK: - Actions
    //
    @IBAction func showFullInfoButtonTapped(_ sender: UIButton) {
        
        if shouldHideSection == true {
        sender.setTitle("Показать меньше",for: .normal)
        sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            tableView.backgroundColor = UIColor.groupTableViewBackground
            tableView.separatorStyle = .singleLine
            
            shouldHideSection = false
            
        } else {
             sender.setTitle("Показать больше",for: .normal)
            tableView.backgroundColor = UIColor.white
            tableView.separatorStyle = .none
            shouldHideSection = true
           sender.imageView?.transform = CGAffineTransform.identity
        }
            self.tableView.reloadData()
            self.tableView.scrollToBottomRow()
     
    }
    @IBAction func EditProfileButtonTapped(_ sender: UIButton) {
       
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let editProfileViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
               editProfileViewController.userData = self.user
               editProfileViewController.delegate = self
        
        if let avatar = self.avatarImage {
            editProfileViewController.avatarImage = avatar
        }
               self.show(editProfileViewController, sender: self)
        }
    }
    
    @IBAction func LogoutButtonTapped(_ sender: UIButton) {

        if let user = user {
            
            ProfileNetworkingService.logout(userId: user.id, authkey: user.authkey) { (response) in
                guard let response = response else {
                    self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                    return }
                if response.errorCode == "c0" {
                    
                    self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
                    
                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    if  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FirstPageViewController") as? FirstPageViewController {
                      
                           let navController = UINavigationController(rootViewController: nextViewController) // Creating a navigation controller with VC1 at the root of the navigation stack.
                        navController.modalPresentationStyle = .fullScreen
                           self.present(navController, animated:true, completion: nil)
                    self.view.activityStopAnimating()
                    }
                } else {
                    let errorDescription = ErrorHandler.errorHandler(errorCode: response.errorCode).errorDescription
                    
                     print(errorDescription)
                    
                    if let errorAlert = ErrorHandler.errorHandler(errorCode: response.errorCode).errorAlert {
                        self.displayMessage(userMessage: errorAlert)
                        self.view.activityStopAnimating()
                                }
                            }
                        }
                    }
                }
            }
//
// MARK: - Table View Delegate
//
extension ProfileViewController: UITableViewDelegate {}
//
// MARK: - Table View Data Source
//
extension ProfileViewController: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         var numberOfRows = Int()
        switch section {
           
        case 0: numberOfRows = 1
        case 1:
        
        if shouldHideSection == true {
            numberOfRows = 0
        } else{
            numberOfRows = cell3Data.count
            }
        case 2: if shouldHideSection == true {
            numberOfRows = 0
        } else{
            numberOfRows = 1
            }
        default:
            return 0
        }
       return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? Cell1TableViewCell {
        cell1.avatarImageView.layer.cornerRadius = 55
        cell1.nameLabel.text = self.user?.name
        cell1.avatarImageView.image = self.avatarImage
        cell1.cityLabel.text = self.user?.city
            
        cell = cell1
            
        if self.isPhotoEdited == false {
                       cell1.activityIndicator.startAnimating()
                   } else {
                       cell1.activityIndicator.stopAnimating()
                   }
            }
        case 1:
               
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
                       cell2.textLabel?.text = cell3Data[indexPath.row].0
                       cell2.detailTextLabel?.text = cell3Data[indexPath.row].1
                       cell = cell2
        case 2:
                      
                   let cell3 = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
                   if self.user?.about == "" {
                             cell3.textLabel?.text = "Не заполнено"
                         } else {
                             cell3.textLabel?.text = self.user?.about
                         }
                              cell = cell3
        default:
            return cell
        }
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        let headerHeight: CGFloat

        switch section {
        case 0,1 :
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 21
        }

        return headerHeight
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleForHeader = String()
        switch section {
        case 0,1:
            titleForHeader = ""
        case 2:
            
           if shouldHideSection == true {
                titleForHeader = ""
            } else{
               titleForHeader = "О себе"
                }
        default:
            titleForHeader = ""
        }
        return titleForHeader
    }
}
