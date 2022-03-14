import UIKit
    //
    // MARK: - Protocols
    //
protocol EditProfileDetailViewControllerDelegate : NSObjectProtocol{
    func updateUserData(userData: UserData)
}

class EditProfileDetailViewController: UIViewController {
    //
    // MARK: - Variables And Properties
    //
    weak var delegate : EditProfileDetailViewControllerDelegate?
    var sportIndexPath: IndexPath?
    var goalIndexPath: IndexPath?
    var cityIndexPath: IndexPath?
    var name = String()
    var age = String()
    var city = String()
    var goal = String()
    var sport = String()
    var about = String()
    
    var cellIndex: Int?
    var itemIndex: Int?
    var text : String?
    var data = ""
    var userData: UserData?

    //
    // MARK: - View Controller
    //
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch cellIndex {
        case 1: userData?.age = textField.text ?? ""
        case 3: userData?.about = textField.text ?? ""
        default:
            print("")
            }
       }
    //
    // MARK: - Actions
    //
     @IBAction func doneButtonTapped(_ sender: UIButton) {

         self.view.endEditing(true)
    
        if cityIndexPath != nil {
            if let cityIndexPath = cityIndexPath?.row {
         userData?.city = cities[cityIndexPath]
            }
         
         
        }
         if goalIndexPath != nil {
            if let goalIndexPath = goalIndexPath?.row {
          userData?.goals = goals[goalIndexPath]
            }
         }
         if sportIndexPath != nil {
            if let sportIndexPath = sportIndexPath?.row {
          userData?.sport = sports[sportIndexPath]
            }
         }
        if let delegate = delegate{
            if let userData = userData {
         delegate.updateUserData(userData: userData)
            }
        }
         self.navigationController?.popViewController(animated: true)
     }
}
//
// MARK: - Table View Data Source
//
extension EditProfileDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = Int()
        
        if cellIndex == 1 {
            switch itemIndex {
          
            case 0 : numberOfRows = 2
            case 1 : numberOfRows = 1
               
            default:
                print("")
            }
        } else if cellIndex == 2 {
            numberOfRows = 4
        } else {
           numberOfRows = 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if cellIndex == 1 {
            switch itemIndex {
            case 0:
                       let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
                       cell2.textLabel?.text = cities[indexPath.row]
                       if cities[indexPath.row] == userData?.city {
                           cityIndexPath = indexPath
                       }
                      
                       cell = cell2
            case 1 :
                if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? EditProfileFirstTableViewCell {
                     cell1.textField.delegate = self
                     cell1.textField.tag = 1
                
                cell1.textField.text = userData?.age
                     cell1.textField.keyboardType = UIKeyboardType.phonePad
                
                cell = cell1
                }
                
            default:
                print("")
            }
            
        } else if cellIndex == 2 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            switch itemIndex {
            case 0: cell2.textLabel?.text = sports[indexPath.row]
                if sports[indexPath.row] == userData?.sport {
                    sportIndexPath = indexPath
                }
            case 1: cell2.textLabel?.text = goals[indexPath.row]
               if goals[indexPath.row] == userData?.goals {
                    goalIndexPath = indexPath
                }
            default:
                print("error")
            }
                cell = cell2
        } else {
            if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? EditProfileFirstTableViewCell {
                                cell1.textField.delegate = self
                                cell1.textField.tag = 1
            cell1.textField.placeholder = "О себе"
            if self.userData?.about == "" {
                cell1.textField?.text = ""
            } else {
                cell1.textField?.text = self.userData?.about
                
            }
                           cell = cell1
        }
        }
       
        if cell.textLabel?.text == userData?.city {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            
            
        }
        if cell.textLabel?.text == userData?.goals {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
           
        }
        if cell.textLabel?.text == userData?.sport {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            
        }
        cell.selectionStyle = .none
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellIndex == 1 {
            switch itemIndex {
           
            case 0 :
                if let cityIndexPath = cityIndexPath {
                    tableView.cellForRow(at:cityIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                }
                cityIndexPath = indexPath
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                case 1 : print("ll")
            default:
                print("")
            }
        } else if cellIndex == 2 {
            switch itemIndex {
            case 0 :
                if let sportIndexPath = sportIndexPath {
                    tableView.cellForRow(at:sportIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                }
                           sportIndexPath = indexPath
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            case 1 :
                  if let goalIndexPath = goalIndexPath {
                    tableView.cellForRow(at:goalIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                  }
                goalIndexPath = indexPath
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
               
            default:
                print("")
            }

        } else {

        }
    }
}
//
// MARK: - Table View Delegate
//
extension EditProfileDetailViewController: UITableViewDelegate{}
//
// MARK: - Text Field Delegate
//
extension EditProfileDetailViewController: UITextFieldDelegate {}
