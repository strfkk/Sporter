import UIKit

class ChatViewController: UIViewController {
    //
    // MARK: - Variables And Properties
    //
    var messages = [MessagesResponseData]()

    var profileData: UserData?
    var userId = Int()
    var userName = String()
    
    var noMessagesLabel = UILabel()
    var dialogIsEmpty = Bool()
    var timer: Timer?
    var defaultCheckmarkImage = UIImage()
    let checkmarkImage = UIImage(named: "checkmark")
    let doubleCheckmarkImage = UIImage(named: "doubleCheckmark")
    var lightBlueColor = UIColor(red: 0, green: 0.3804, blue: 1, alpha: 1.0)
    var isTransitionFromUserProfile = false
    var avatar = UIImage()
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var userProfileButton: UIButton!
    //
    // MARK: - View Controller
    //
    func GetMessagesData() -> [MessagesResponseData]? {
        var messages : [MessagesResponseData]?
        if let profileData = profileData {
            ChatNetworkingService.getMessages(id: profileData.id, userId: userId, authkey: profileData.authkey) { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
            if response.errorCode == "m1" {
                self.noMessagesLabel = self.createMessageLabel(text: "Нет сообщений")
                self.view.addSubview(self.noMessagesLabel)
                            self.dialogIsEmpty = true
                } else if response.errorCode == "c0" {
                    messages = response.messagesResponseBody.reversed()
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
                        return messages
                }
    
    func MarkReadMessages(messages: [MessagesResponseData]){
        if let profileData = profileData {
        for message in messages {
            if message.read == false && message.senderId != self.userId {
                ChatNetworkingService.markReadMessage(mid: message.id, userId: self.userId, authkey: profileData.authkey) { (response) in
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if isTransitionFromUserProfile == true {
            self.userProfileButton.isHidden = true
        }

        self.title = self.userName
        let origImage = UIImage(named: "45-Send-512")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        sendMessageButton.setImage(tintedImage, for: .normal)
        sendMessageButton.tintColor = lightBlueColor
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        messageTextField.delegate = self
        tableView.separatorStyle = .none

        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    // Get Messages Data
        self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        if let messages = self.GetMessagesData() {
        
            self.MarkReadMessages(messages: messages)
            self.messages = messages
            self.tableView.reloadData()
            self.scrollToBottomOfChat()
            self.noMessagesLabel.isHidden = true
            self.dialogIsEmpty = false
            }
        self.view.activityStopAnimating()
    
    
        // Update messages
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (t) in
            if let updatedMessages = self.GetMessagesData() {
                if updatedMessages.count == self.messages.count {
                    print("Нет новых сообщений")
                    
                    for message in self.messages {
                        for updatedMessage in updatedMessages {
                            if message.read == updatedMessage.read {
                                print("Нет обновлений по прочитанным сообщениям")
                            } else {
                                self.messages = updatedMessages
                                self.tableView.reloadData()
                            }
                        }
                    }
                } else {
                    print("обновляю сообщения")
                    self.messages = updatedMessages
                    self.tableView.reloadData()
                    self.scrollToBottomOfChat()
                    self.noMessagesLabel.isHidden = true
                    self.dialogIsEmpty = false
                        }
                    }
                }
            }

    override func viewWillDisappear(_ animated: Bool) {
        print("вышли из диалога")
        self.timer?.invalidate()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    func scrollToBottomOfChat(){
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
      
        noMessagesLabel.isHidden = true
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print(self.messageTextfieldBottomConstraint.constant)
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.messageTextfieldBottomConstraint.constant = keyboardFrame.size.height
            print(self.messageTextfieldBottomConstraint.constant)

            self.view.layoutIfNeeded()
            if self.messages.count != 0 {
                self.scrollToBottomOfChat()
            } else {
                print("no messages")
            }
        })
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
           hideKeyboard()
           return true
       }
    @objc func keyboardWillHide(notification:NSNotification) {

        if dialogIsEmpty == true {
            noMessagesLabel.isHidden = false
        } else {
        noMessagesLabel.isHidden = true
        }
        messageTextfieldBottomConstraint.constant = 0
        
        hideKeyboard()
        tableView.reloadData()
        if self.messages.count != 0 {
            self.scrollToBottomOfChat()
        } else {
            print("no messages")

        }
    }
    
    func hideKeyboard() {
        messageTextField.resignFirstResponder()
    }
    //
    // MARK: - Actions
    //
    @IBAction func userProfileButtonTapped(_ sender: UIButton) {
        if let profileData = profileData {
        ChatNetworkingService.getUserInfo(id: profileData.id, userId: userId, authkey: profileData.authkey) { (response) in
               if response?.errorCode == "c0" {
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                if let userProfileViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController {
                userProfileViewController.isTransitionFromChat = true
                userProfileViewController.avatar = self.avatar
                   if let responseData = response?.userInfoBody {
                       userProfileViewController.userData = responseData
                       
                                 self.show(userProfileViewController, sender: self)
                        }
                   }
               } else {
                self.displayMessage(userMessage: "Ошибка получения данных")
                        }
                    }
                }
            }
        
    @IBAction func sendMessageButtonTapped(_ sender: UIButton) {
        
        hideKeyboard()
        self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: UIColor.white.withAlphaComponent(0.5))
       if messageTextField.text?.isEmpty ?? true {
            print("textField is empty")
        } else {
            if let message = messageTextField.text {
                if let profileData = profileData {
        
                ChatNetworkingService.sendMessage(id: profileData.id, userId: userId, authkey: profileData.authkey, text: message) { (response) in
                    if let messages = self.GetMessagesData() {
                    
                        self.MarkReadMessages(messages: messages)
                        self.messages = messages
                        self.tableView.reloadData()
                        self.scrollToBottomOfChat()
                        self.noMessagesLabel.isHidden = true
                        self.dialogIsEmpty = false
                            }
                        }
                    }
                    messageTextField.text = ""
                }
            }
            self.view.activityStopAnimating()
                }
            }
    //
    // MARK: - Table View Delegate
    //
extension ChatViewController: UITableViewDelegate {}
    //
    // MARK: - Table View Data Source
    //
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChatTableViewCell {
        
        cell1.bubleBackgroundView.layer.cornerRadius = 21
        cell1.messageLabel.text = messages[indexPath.row].text
        cell1.messageLabel.sizeToFit()
        cell1.timeLabel.text = getTime(date: messages[indexPath.row].sendDate)
        

        if messages[indexPath.row].read == false {
            if let checkmarkImage = UIImage(named: "checkmark") {
               let tintableImage = checkmarkImage.withRenderingMode(.alwaysTemplate)
               cell1.unreadImage.image = tintableImage
               cell1.unreadImage.tintColor = .white
               }
           } else {
               if let checkmarkImage = UIImage(named: "doubleCheckmark") {
                                     let tintableImage = checkmarkImage.withRenderingMode(.alwaysTemplate)
                                   cell1.unreadImage.image = tintableImage
                                   cell1.unreadImage.tintColor = .white
               }
        }
        if (messages[indexPath.row].senderId == userId ) {
                  cell1.isComing = false
               } else {
                   cell1.isComing = true
               }

        cell1.selectionStyle = .none
            
        cell = cell1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}
    //
    // MARK: - Text Field Delegate
    //
extension ChatViewController: UITextFieldDelegate {}
