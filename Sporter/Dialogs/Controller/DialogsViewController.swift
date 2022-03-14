import UIKit

class DialogsViewController: UIViewController, UITabBarControllerDelegate {
    //
    // MARK: - Variables And Properties
    //
    var user: UserData?
    var dialogsData = [Chats]()
    
    var noDialogsLabel = UILabel()
    var timer: Timer?
    var dialogsImages = [Int:UIImage]()
    var defaultAvatar = UIImage(named: "111")
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    //
    // MARK: - View Controller
    //

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.separatorStyle = .none
        self.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.white.withAlphaComponent(0.5))

        self.tabBarController?.delegate = self
        
    // Get Dialogs Data
        if let user = self.user {
        DialogsNetworkingService.getDialogs(userData: user) { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
            if response.errorCode == "m3" {
                self.noDialogsLabel = self.createMessageLabel(text: "Нет диалогов")
                self.view.addSubview(self.noDialogsLabel)
                self.tableView.isScrollEnabled = false
            } else {
                self.noDialogsLabel.isHidden = true
                self.tableView.isScrollEnabled = true
                if let chats = response.dialogsResponseBody?.chats {
                self.dialogsData = chats
                }
            }
                
    // Get Users Images
                for (_, element) in self.dialogsData.enumerated() {
                    if let user = self.user {
                                    
                        if let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(user.id)&authkey=\(user.authkey)&id=\(element.userId)") {
                                     
                            if let data = NetworkingService.shared.downloadImage(from: url, id: element.userId) {
                            DispatchQueue.main.async() { [weak self] in
                                if let image = UIImage(data: data) {
                                    self?.dialogsImages.updateValue(image, forKey: element.userId)
                                        self?.tableView.reloadData()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
        self.view.activityStopAnimating()
        
    // Updating dialogs data
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (t) in
            DialogsNetworkingService.getDialogs(userData: self.user!) { (response) in
                guard let response = response else {
                    print("response не записался")
                    return }
                if response.errorCode == "m3" {
                    self.noDialogsLabel = self.createMessageLabel(text: "Нет диалогов")
                    self.view.addSubview(self.noDialogsLabel)
                        self.tableView.isScrollEnabled = false
                } else if response.errorCode == "c0" {
                        
                        self.tableView.isScrollEnabled = true
                        
                        var updatedChats = [Chats]()
                        
                        updatedChats = (response.dialogsResponseBody!.chats)
                         if updatedChats[0].lastMessage == self.dialogsData[0].lastMessage {
                            print("Нет изменений ")
                        } else {
                            print("Диалоги обновлены")
                            self.dialogsData = updatedChats
                                                   self.tableView.separatorStyle = .singleLine
                                                   self.tableView.reloadData()
                    }
                } else  {
                    if let errorAlert = ErrorHandler.errorHandler(errorCode: response.errorCode).errorAlert {
                        self.displayMessage(userMessage: errorAlert)
                        self.view.activityStopAnimating()
                    }
                }
            }
        }
    }
    
     override func viewWillDisappear(_ animated: Bool) {
            print("вышли из диалогов")
            self.timer?.invalidate()
            }
    }
    //
    // MARK: - Table View Delegate
    //
extension DialogsViewController: UITableViewDelegate {}
    //
    // MARK: - Table View Data Source
    //
extension DialogsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DialogsTableViewCell {
        cell1.dialogsImageView.image = defaultAvatar
        
         if self.dialogsData.count != 0 {
             
             for (id, image) in dialogsImages {
        
                if id == dialogsData[indexPath.row].userId {
                     cell1.dialogsImageView.image = image
                 }
             }
         }
        
        cell1.messageLabel.text = dialogsData[indexPath.row].lastMessage
        cell1.nameLabel.text = dialogsData[indexPath.row].userName
        cell1.sendDateLabel.text = getTime(date: dialogsData[indexPath.row].lastMessageDate)
        if (dialogsData[indexPath.row].unread == 0 ){ cell1.isReadView.isHidden = true
        } else {
            cell1.isReadView.isHidden = false
        }
        
            cell1.isReadView.layer.cornerRadius = 5
            cell1.selectionStyle = .none
            cell1.dialogsImageView.layer.cornerRadius = 27.5
            cell1.dialogsImageView.clipsToBounds = true
            
            cell = cell1
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogsData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let chatViewController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
        
        var avatar = self.defaultAvatar
               
               if self.dialogsImages.count != 0 {
                      
                      for (id, image) in dialogsImages {
                 
                          if id == dialogsData[indexPath.row].userId {
                              avatar = image
                                   
                          }
                      }
                  }
            if let user = user {
                if let avatar = avatar {
                    chatViewController.avatar = avatar }
                chatViewController.profileData = user
              
            }
            chatViewController.userName = dialogsData[indexPath.row].userName
            chatViewController.userId = dialogsData[indexPath.row].userId
        self.show(chatViewController, sender: self)
        }
    }
}
