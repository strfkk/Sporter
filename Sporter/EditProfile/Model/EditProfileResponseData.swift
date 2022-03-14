import Foundation

func nullToNil(value : Any?) -> Any? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}

struct EditProfileResponseData {
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
          //NOT NULL
        }
        else
        {
            descr = ""
           //NULL
        }
        
        guard
            let goals = dict["goals"] as? Int,
            let cityId = dict["cityID"] as? Int,
            let gender = dict["sex"] as? Int,
            let lastOnline = dict["lastOnline"] as? String,
            let sportId = dict["sportID"] as? Int,
            let age = dict["age"] as? Int,
            let id = dict["id"] as? Int,
            let name = dict["name"] as? String

            else { return nil }
        
            self.about = descr
            self.age = age
            self.gender = gender
            self.cityId = cityId
            self.goals = goals
            self.id = id
            self.lastOnline = lastOnline
            self.name = name
            self.sportId = sportId
    }
}
