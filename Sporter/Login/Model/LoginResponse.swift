import Foundation

struct LoginResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var loginResponseBody: ResponseData?
    //
    // MARK: - Initializer
    //
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
        if let errorCode = response["errorCode"] as? String {
            self.errorCode = errorCode
        }
        if let loginResponseBody = response["body"] as? [String : Any] {
            let body = ResponseData(dict: loginResponseBody)
            self.loginResponseBody = body
            }
        }
    }
    

