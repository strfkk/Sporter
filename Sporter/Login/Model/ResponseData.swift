import Foundation

struct ResponseData {
    //
    // MARK: - Variables And Properties
    //
    var about: String
    var goals: Int
    var cityId: Int
    var gender: Int
    var lastOnline: String
    var sportId: Int
    var age: Int
    var authkey: String
    var id: Int
    var name: String
    //
    // MARK: - Initializer
    //
    init?(dict: [String: Any]) {
        var descr = String()
        if let about = (dict["about"] as? String)
        {
            descr = about
        }
        else
        {
            descr = ""
        }
        guard
            let goals = dict["goals"] as? Int,
            let cityId = dict["cityID"] as? Int,
            let gender = dict["sex"] as? Int,
            let lastOnline = dict["lastOnline"] as? String,
            let sportId = dict["sportID"] as? Int,
            let age = dict["age"] as? Int,
            let authkey = dict["authkey"] as? String,
            let id = dict["id"] as? Int,
            let name = dict["name"] as? String

            else { return nil }
  
            self.about = descr
            self.age = age
            self.gender = gender
            self.authkey = authkey
            self.cityId = cityId
            self.goals = goals
            self.id = id
            self.lastOnline = lastOnline
            self.name = name
            self.sportId = sportId
        }
    }
