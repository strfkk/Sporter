import Foundation

struct LogoutResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
   //
   // MARK: - Initializer
   //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
        if let errorCode = response["errorCode"] as? String {
            self.errorCode = errorCode
        }
    }
}
