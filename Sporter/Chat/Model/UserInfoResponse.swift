
import Foundation

struct UserInfoResponse {
    //
    // MARK: - Variables And Properties
    //
    var userInfoBody : SearchResponseData?
    var errorCode = String()

    //
    // MARK: - Initializer
    //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
      
        if let userInfoBody = response["body"] as? [String : Any] {
      
            let body = SearchResponseData(dict: userInfoBody)
            self.userInfoBody = body

        }
        if let errorCode = response["errorCode"] as? String {
            self.errorCode = errorCode
            }
        }
    }
    
