import Foundation

struct MessagesResponseData {
    //
    // MARK: - Variables And Properties
    //
    var id: Int
    var senderId: Int
    var receiverId: Int
    var sendDate: String
    var read: Bool
    var text: String
    //
    // MARK: - Initializer
    //
    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let senderId = dict["senderID"] as? Int,
            let receiverId = dict["receiverID"] as? Int,
            let sendDate = dict["sentDate"] as? String,
            let read = dict["read"] as? Bool,
            let text = dict["text"] as? String

            else { return nil }
  
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.sendDate = sendDate
        self.read = read
        self.text = text
    }
}
