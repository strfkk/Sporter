import Foundation

struct newUserResponseData {
    //
    // MARK: - Variables And Properties
    //
    var authkey: String
    var id: Int
    //
    // MARK: - Initializer
    //
    init?(dict: [String: Any]) {
        guard let authkey = dict["authkey"] as? String,
            let id = dict["id"] as? Int
            else { return nil }

        self.authkey = authkey
        self.id = id
    }
}
