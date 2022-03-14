import UIKit

class SearchViewController: UIViewController, SearchSettingsViewControllerDelegate {
    //
    // MARK: - Variables And Properties
    //
    var searchResult = [SearchResponseData]()
    var searchRequestData: SearchRequestData?
    var user : UserData?
    
    var noSearchResultLabel = UILabel()

    var searchResuldIds = [Int]()
    var searchResultImages = [Int:UIImage]()   
    var defaultAvatar = UIImage(named: "111")!
    
    var index = IndexPath()
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var searchResultTableView: UITableView!
    //
    // MARK: - View Controller
    //

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getSearchResult(requestData: SearchRequestData) {

        self.searchRequestData = requestData
         self.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        
        if let searchRequestData = searchRequestData {
        SearchNetworkingService.getSearchResult(requestData: searchRequestData) { (response) in
            guard let response = response else {
                self.displayMessage(userMessage: "Произошла ошибка. Попробуйте еще раз")
                return }
            if response.errorCode == "c0" {
                if response.searchResponseBody.count == 0 {
                self.searchResult = []
                self.searchResultTableView.reloadData()
                self.noSearchResultLabel = self.createMessageLabel(text: "Пользователей не найдено")
                self.view.addSubview(self.noSearchResultLabel)
                self.view.activityStopAnimating() } else {
      
                       self.searchResult = response.searchResponseBody
                
                for (index, element) in self.searchResult.enumerated() {
                                  
                                  if element.id == self.user?.id {
                                  self.searchResult.remove(at: index)
                                }
                    if let user = self.user {
                        // Get users images
                        if let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(user.id)&authkey=\(user.authkey)&id=\(element.id)") {
                            if let data = NetworkingService.shared.downloadImage(from: url, id: user.id) {
                            DispatchQueue.main.async() { [weak self] in
                                if let image = UIImage(data: data) {
                                    self?.searchResultImages.updateValue(image, forKey: element.id)
                                            }
                                self?.searchResultTableView.reloadData()
                                                    }
                                                  }
                                               }
                                             }
                
                self.searchResultTableView.reloadData()
                if self.searchResult.count == 0 {
                    self.noSearchResultLabel = self.createMessageLabel(text: "Пользователей не найдено")
                    self.view.addSubview(self.noSearchResultLabel)
                } else {
                    self.noSearchResultLabel.isHidden = true
                        }
                      }
                    }
                }
        self.view.activityStopAnimating()
                }
            }
        }

    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchResultTableView.reloadData()
        searchResultTableView.separatorStyle = .none
        
        self.view.activityStartAnimating(activityColor: UIColor.black, backgroundColor: UIColor.white.withAlphaComponent(0.5))
        
        // Get Search result
        if let searchRequestData = searchRequestData {
            self.getSearchResult(requestData: searchRequestData)
           
        } else {
            print("user == nil")
            self.displayMessage(userMessage: "Ошибка загрузки данных, попробуйте еще раз")
        }
    }
    //
    // MARK: - Actions
    //
    @IBAction func searchSettingsButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let searchSettingsViewController = storyBoard.instantiateViewController(withIdentifier: "SearchSettingsViewController") as? SearchSettingsViewController {
            if let requestData = searchRequestData {
               let searchSettingsData = convertSearchRequestDataToSearchSettingsData(requestData: requestData)
               searchSettingsViewController.searchSettingsData = searchSettingsData
            }
            searchSettingsViewController.delegate = self
               
        self.show(searchSettingsViewController, sender: self)
        }
    }
}
//
// MARK: - Table View Delegate
//
extension SearchViewController: UITableViewDelegate {}

//
// MARK: - Table View Data Source
//
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      var cell = UITableViewCell()
        if let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? searchResultTableViewCell {
        
         cell1.avatarImageView.image = self.defaultAvatar
        
        if self.searchResultImages.count != 0 {
            for (id, image) in searchResultImages {
                if id == searchResult[indexPath.row].id {
                    cell1.avatarImageView.image = image
                }
            }
        }
        cell1.nameLabel.text = searchResult[indexPath.row].name

        cell1.ageLabel.text = String(searchResult[indexPath.row].age)
            cell = cell1
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let userProfileViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController {
        
        userProfileViewController.userData = self.searchResult[indexPath.row]
        userProfileViewController.user = self.user
       
        var avatar = self.defaultAvatar
        
        if self.searchResultImages.count != 0 {
               
               for (id, image) in searchResultImages {
                   if id == searchResult[indexPath.row].id {
                       avatar = image
                   }
               }
           }
        userProfileViewController.avatar = avatar
        self.show(userProfileViewController, sender: self)
        }
    }
}


