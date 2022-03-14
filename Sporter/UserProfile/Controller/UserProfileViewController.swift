import UIKit

class UserProfileViewController: UIViewController {
   //
   // MARK: - Variables And Properties
   //
    var avatar = UIImage()
    var userData : SearchResponseData?
    var user : UserData?
    var searchResultImages = [Int:UIImage]()
    var isTransitionFromChat = false
    
    var cell2Data = [
               ("Город",""),
               ("Спорт",""),
               ("Ищет","")
           ]
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
 
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userData = userData {
        let data = convertResponseDatatoUserData1(responseData: userData)
        
         cell2Data = [
            ("Город","\(String(describing: data.city))"),
            ("Спорт","\(String(describing: data.sport))"),
            ("Ищет","\(String(describing: data.goals))")
                  ]
        }
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
      //
      // MARK: - Actions
      //
       @IBAction func sendMessageButtonTapped(_ sender: Any) {
    
        if let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
        newViewController.isTransitionFromUserProfile = true
            newViewController.profileData?.id = userData?.id ?? 0
           newViewController.userName = userData?.name ?? ""
           newViewController.profileData = self.user
           
                  self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
        }
    //
    // MARK: - Table View Delegate
    //
extension UserProfileViewController: UITableViewDelegate {}
    //
    // MARK: - Table View Data Source
    //
extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         var numberOfRows = Int()
               
               switch section {
               case 0: numberOfRows = 1
               case 1: if isTransitionFromChat == true {
                numberOfRows = 0
               } else {
                numberOfRows = 1
                }
               case 2: numberOfRows = 3
               case 3: numberOfRows = 1
               default:
                   print("Количество секций не определено")
               }
               return numberOfRows
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let userData = userData {
        
        if indexPath.section == 0 {

            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? UserProfileTableViewCell {
           
            cell1.userImageView.image = self.avatar
            
            cell1.nameLabel.text = userData.name
            if userData.age == 0 {
                 cell1.ageLabel.text = "0"
            } else {
                cell1.ageLabel.text = String(describing: userData.age)
            }
            cell = cell1
            }
            
        } else if indexPath.section == 1 {
           let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
          cell = cell2
            
        } else if indexPath.section == 2 {
                  let cell3 = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
                   
                   cell3.textLabel?.text = cell2Data[indexPath.row].0
                   cell3.detailTextLabel?.text = cell2Data[indexPath.row].1
                   
            cell = cell3
               } else if indexPath.section == 3 {
                   let cell4 = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath)
           if self.userData?.about == "" {
                cell4.textLabel?.text = "Не заполнено"
            } else {
            cell4.textLabel?.text = self.userData?.about
                
            }
                cell = cell4
               }
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          if section == 2 {
                      return "Основная информация"
                  } else if section == 3 {
                      return "О себе"
                  } else {
                      return ""
                  }
                }
            }
extension UserProfileViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let a = scrollView.contentOffset
            if a.y <= 0 {
                scrollView.contentOffset = CGPoint.zero // this is to disable tableview bouncing at top.
                }
            }
        }
    }
