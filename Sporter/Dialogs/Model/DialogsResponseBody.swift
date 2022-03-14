
import Foundation

struct DialogsResponseBody {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var chats = [Chats]()
    var unread = Bool()
    //
    // MARK: - Initializer
    //
    init(json: Any)  {
        guard let response = json as? NSDictionary else { return }
    if let errorCode = response["errorCode"] as? String {
                   self.errorCode = errorCode
               }
      
        if let responseBody = response["chats"] as? [[String: Any]]  {
            
            for element in responseBody {
                print(element)
                let chat = Chats(dict: element)

                self.chats.append(chat!)
            }
   
            if let unread = response["unread"] as? Bool {
                self.unread = unread
            }
        }
    }
}
        
    
