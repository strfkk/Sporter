import Foundation

struct UserData {
    //
    // MARK: - Variables And Properties
    //
    var about: String
    var lastOnline: String
    var age: String
    var authkey: String
    var id: Int
    var name: String
    var sport: String
    var goals: String
    var city: String
    var gender: String
    //
    // MARK: - Initializer
    //
    init?(about: String, lastOnline: String, age: String, authkey: String, id: Int,  name: String, sport: String, goals: String, city: String, gender: String ) {
        
        self.about = about
        self.age = age
        self.authkey = authkey
        self.lastOnline = lastOnline
        self.name = name
        self.id = id
        self.sport = sport
        self.goals = goals
        self.city = city
        self.gender = gender
        }
    }
