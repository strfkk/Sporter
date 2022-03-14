import Foundation
struct DialogsResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var dialogsResponseBody : DialogsResponseBody?
    //
    // MARK: - Initializer
    //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
    
      
        if let responseBody = response["body"] as? [String : Any] {
            let drb =  DialogsResponseBody(json: responseBody)
  
                self.dialogsResponseBody = drb
            }
        
        if let errorCode = response["errorCode"] as? String {
            self.errorCode = errorCode
        }
    }
}
        
        
    
