import Foundation
struct SetPhotoResponse {
//
// MARK: - Variables And Properties
//
var errorCode = String()
var body = String()

//
// MARK: - Initializer
//
    init(dict: [String: Any]) throws {
     let response = dict as NSDictionary
        if let errorCode = response["errorCode"] as? String {
      self.errorCode = errorCode
  }
        if let body = response["body"] as? String {
            self.body = body
        }
    }

}
