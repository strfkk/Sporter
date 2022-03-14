
import Foundation
struct SearchResponse {
    //
    // MARK: - Variables And Properties
    //
    var errorCode = String()
    var searchResponseBody = [SearchResponseData]()
    
    //
    // MARK: - Initializer
    //
    
    init(json: Any) throws {
        guard let response = json as? NSDictionary else { throw ErrorHandler.NetworkingError.jsonCastingError }
    
        if let errorCode = response["errorCode"] as? String {
                self.errorCode = errorCode
            }
      
        if let responseBody = response["body"] as? [[String: Any]]  {
            
            for element in responseBody {

                let user = SearchResponseData(dict: element)
                if let user = user {
                    
                    self.searchResponseBody.append(user)
                }
            }
        }
    }
}
        
    
