import Foundation
struct Chats {
    //
    // MARK: - Variables And Properties
    //
    var userId: Int
    var userName: String
    var lastMessage: String
    var lastMessageDate: String
    var unread: Int
    //
    // MARK: - Initializer
    //
    init?(dict: [String: Any]) {
        guard let userId = dict["userID"] as? Int,
            let userName = dict["userName"] as? String,
            let lastMessage = dict["lastMessage"] as? String,
            let lastMessageDate = dict["lastMessageDate"] as? String,
            let unread = dict["unread"] as? Int

            else { return nil }
  
        self.userId = userId
        self.userName = userName
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
        self.unread = unread
    }
}
