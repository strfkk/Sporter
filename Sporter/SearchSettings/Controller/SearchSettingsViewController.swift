
//
// MARK: - Protocols
//
protocol SearchSettingsViewControllerDelegate : NSObjectProtocol{
    func getSearchResult(requestData: SearchRequestData )
}
import UIKit

class SearchSettingsViewController: UIViewController {
    //
    // MARK: - Variables And Properties
    //
    weak var delegate : SearchSettingsViewControllerDelegate?
    var searchSettingsData : SearchSettingsData?
    var sportIndexPath = IndexPath()
    var goalIndexPath = IndexPath()
    var cityIndexPath = IndexPath()
    var genderIndexPath = IndexPath()

    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    //
    // MARK: - Actions
    //
    @IBAction func doneButtonTapped(_ sender: UIButton) {

        let searchSettingsData = SearchSettingsData(cityIndex: cityIndexPath.row, sportIndex: sportIndexPath.row, goalIndex: goalIndexPath.row, genderIndex: 0, id: self.searchSettingsData!.id, authkey: self.searchSettingsData!.authkey)
        let searchRequestData = convertSearchSettingsDataToSearchRequestData(searchSettingsData: searchSettingsData!)!
        
        if let delegate = delegate{
               delegate.getSearchResult(requestData: searchRequestData)
              }
               self.navigationController?.popViewController(animated: true)
    }
}
    //
    // MARK: - Table View Delegate
    //
extension SearchSettingsViewController: UITableViewDelegate {}
    //
    // MARK: - Table View Data Source
    //
extension SearchSettingsViewController: UITableViewDataSource {
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
               case 1: title = "Выберите спорт"
               case 2: title = "Вы ищите"
          
               default:
                  title = ""
               }
               return title
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let searchSettingsData = searchSettingsData {
        switch indexPath.section {
        case 0: cell.textLabel?.text = cities[indexPath.row]
           
            if cell.textLabel?.text == cities[searchSettingsData.cityIndex] {
                    cell.accessoryType =
                        UITableViewCell.AccessoryType.checkmark
                cityIndexPath = IndexPath(row: searchSettingsData.cityIndex, section: 0)
                }
                
        case 1: cell.textLabel?.text = sports[indexPath.row]
            if cell.textLabel?.text == sports[searchSettingsData.sportIndex] {
                                   cell.accessoryType =
                                       UITableViewCell.AccessoryType.checkmark
                sportIndexPath = IndexPath(row: searchSettingsData.sportIndex, section: 1)
                               }
                              
        case 2: cell.textLabel?.text = goals[indexPath.row]
            if cell.textLabel?.text == goals[searchSettingsData.goalIndex] {
                               cell.accessoryType =
                                   UITableViewCell.AccessoryType.checkmark
                goalIndexPath = IndexPath(row: searchSettingsData.goalIndex, section: 2)
                           }
                           
        default: print("")
        }
        }
        cell.selectionStyle = .none
            return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
      
                tableView.cellForRow(at:cityIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
            cityIndexPath = indexPath
                tableView.cellForRow(at: cityIndexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
       case 1:
           tableView.cellForRow(at:sportIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
       sportIndexPath = indexPath
           
           tableView.cellForRow(at: sportIndexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        case 2:
            tableView.cellForRow(at:goalIndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
        goalIndexPath = indexPath
            tableView.cellForRow(at: goalIndexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
               default:
                   print("")
        }
    }
}
