import Foundation

struct SendMessageResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var body = String()
   //
   // MARK: - Initializer
   //
    init?(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
        guard let errorCode = response["errorCode"] as? String,
                  let body = response["body"] as? String

                  else { return nil }
        
              self.errorCode = errorCode
              self.body = body
    }
}

