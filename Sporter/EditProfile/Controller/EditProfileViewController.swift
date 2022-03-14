    //
    // MARK: - Protocols
    //
protocol EditProfileViewControllerDelegate : NSObjectProtocol{
    func updateUserData(userData: UserData1, avatar: UIImage)
}

import UIKit

class EditProfileViewController: UIViewController, EditProfileDetailViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //
    // MARK: - Variables And Properties
    //
    weak var delegate : EditProfileViewControllerDelegate?
    var avatarImage = UIImage(named: "111")
    var userData: UserData?
    var isPhotoEdited: Bool = false
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        self.tableView.reloadData()
    }

    func updateUserData(userData: UserData) {
        self.userData = userData
        tableView.reloadData()
        print(userData)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImage: UIImage?
            var userId = Int()
            var authkey = String()
        if self.userData != nil {
                    userId = self.userData!.id
                    authkey = self.userData!.authkey
               }
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.avatarImage = selectedImage!
            self.isPhotoEdited = true
            self.tableView.reloadData()
            self.setPhoto(image: selectedImage!, userId: userId, authkey: authkey)
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.avatarImage = selectedImage
            self.isPhotoEdited = true
            self.tableView.reloadData()
            
            if let image = selectedImage {
            self.setPhoto(image: image, userId: userId, authkey: authkey)
            }

            picker.dismiss(animated: true, completion: nil)
            }
        }
  
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var tableView: UITableView!
    
    //
    // MARK: - Actions
    //
    @IBAction func setImageButtonTapped(_ sender: UIButton) {
             let image = UIImagePickerController()
                 image.delegate = self
                 image.sourceType = UIImagePickerController.SourceType.photoLibrary
                 image.allowsEditing = false
                  
                self.present(image, animated: true) {
               }
            }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
       guard let user = self.userData
              else { return }
    
        if let requestData = convertUserDataToRequestData(userData: user){
    
        EditProfileNetworkingService.editProfile(requestData: requestData) { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
            if response.errorCode == "c0" {
                
                if let responseBody = response.editProfileResponseBody {
                let userData = convertResponseDatatoUserData2(responseData: responseBody)
                
            if let delegate = self.delegate{
                if let image = self.avatarImage {
                delegate.updateUserData(userData: userData, avatar: image)
            }
                  }
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
            self.navigationController?.popViewController(animated: true)
            self.view.activityStopAnimating()
            }
        }
    }

    //
    // MARK: - Table View Delegate
    //
extension EditProfileViewController: UITableViewDelegate {}

    //
    // MARK: - Table View Data Source
    //
extension EditProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
             return 2
         } else if section == 2 {
             return 2
         } else {
             return 1
         }
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section == 1 {
               return "Основная информация"
           } else if section == 2 {
               return "Интересы"
           } else if section == 3{
               return "О себе"
           } else {
               return ""
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let editProfileDetailViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileDetailViewController") as? EditProfileDetailViewController {
        editProfileDetailViewController.delegate = self
        switch indexPath.section {
        case 1: editProfileDetailViewController.cellIndex = 1
        case 2: editProfileDetailViewController.cellIndex = 2
        case 3: editProfileDetailViewController.cellIndex = 3
            
        default:
            print("error")
        }
        
        switch indexPath.row {
        case 0: editProfileDetailViewController.itemIndex = 0
        case 1: editProfileDetailViewController.itemIndex = 1
                        
        case 2: editProfileDetailViewController.itemIndex = 2
                   
        default:
                   print("error")
               }
        editProfileDetailViewController.userData = self.userData
        self.show(editProfileDetailViewController, sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! SetImageTableViewCell
            if self.isPhotoEdited == true {
                cell.activityIndicator.startAnimating()
            } else {
                cell.activityIndicator.stopAnimating()
            }
                cell.avatarImageView.image = self.avatarImage
            cell.avatarImageView.layer.cornerRadius = 55 
           
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
               cell.selectionStyle = .none

        switch indexPath.row {
       case 0:
            cell.textLabel?.text = "Город"
            cell.detailTextLabel?.text = userData?.city
        case 1:
            cell.textLabel?.text = "Возраст"
            cell.detailTextLabel?.text = userData?.age
       
        default:
            print("error")
        }
            return cell
                }
                else  if indexPath.section == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        
                    cell.selectionStyle = .none
                     switch indexPath.row {
                            case 0:
                                cell.textLabel?.text = "Спорт"
                                cell.detailTextLabel?.text = userData?.sport
                            case 1:
                                cell.textLabel?.text = "Ищу"
                                cell.detailTextLabel?.text = String(userData?.goals ?? "")
                            
                            default:
                                print("error")
                            }
                                return cell
                }
                else  {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
                    cell.selectionStyle = .none
                    if self.userData?.about == "" {
                        cell.textLabel?.text = "Не заполнено"
                    } else {
                        cell.textLabel?.text = self.userData?.about
                    
                    }
                    cell.selectionStyle = .none
    
                    return cell
                }
            }
        }
