
import Foundation

struct SearchSettingsData {
    //
    // MARK: - Variables And Properties
    //
    var cityIndex: Int
    var sportIndex: Int
    var goalIndex: Int
    var genderIndex: Int
    var id: Int
    var authkey: String
   
    //
    // MARK: - Initializer
    //
    init?(cityIndex: Int, sportIndex: Int, goalIndex: Int, genderIndex: Int, id: Int, authkey: String) {
        
        self.cityIndex = cityIndex
        self.sportIndex = sportIndex
        self.goalIndex = goalIndex
        self.genderIndex = genderIndex
        self.id = id
        self.authkey = authkey
  
        }
}
