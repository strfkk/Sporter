import Foundation
struct MessagesResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var messagesResponseBody = [MessagesResponseData]()
    //
    // MARK: - Initializer
    //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
    
        if let responseBody = response["body"] as? [[String: Any]]  {

            for element in responseBody {

                let message = MessagesResponseData(dict: element)
                self.messagesResponseBody.append(message!)
            }
        }
         
           if let errorCode = response["errorCode"] as? String {
                                 self.errorCode = errorCode
                             }
                        }
                    }
        
    
