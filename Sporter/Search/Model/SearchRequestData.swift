import Foundation

struct SearchRequestData {
    //
    // MARK: - Variables And Properties
    //
    var authkey: String
    var id: Int
    var sport: Int
    var goals: Int
    var city: Int
    var sex: Int
    //
    // MARK: - Initializer
    //
    init?( authkey: String, id: Int, sport: Int, goals: Int, city: Int, sex: Int ) {
    
        self.authkey = authkey
        self.id = id
        self.sport = sport
        self.goals = goals
        self.city = city
        self.sex = sex

    }
}
