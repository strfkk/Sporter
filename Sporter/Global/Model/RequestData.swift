import Foundation

struct RequestData {
    //
    // MARK: - Variables And Properties
    //
    var userId: Int
    var authkey: String
    var sex: Int
    var age: Int
    var sport: Int
    var city: Int
    var goals: Int
    var about: String
    
    //
    // MARK: - Initializer
    //
    init?(about: String, userId: Int, authkey: String, sex: Int, age: Int, sport: Int, goals: Int, city: Int) {
           
            self.about = about
            self.age = age
            self.authkey = authkey
            self.userId = userId
            self.sex = sex
            self.sport = sport
            self.goals = goals
            self.city = city
        }
}
