import Foundation

struct newUserResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var newUserResponseBody: newUserResponseData?
    
    //
    // MARK: - Initializer
    //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
      
            if let newUserResponseBody = response["body"] as? [String : Any?] {
                let body = newUserResponseData(dict: newUserResponseBody as [String : Any])
                self.newUserResponseBody = body
        }
        
        if let errorCode = response["errorCode"] as? String {
                self.errorCode = errorCode
                }
            }
        }
    

