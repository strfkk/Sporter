
import Foundation
class ChatNetworkingService {
    private init() {}
    //
    // MARK: - Get Messages Request
    //
    static func getMessages(id: Int, userId: Int, authkey: String,completion: @escaping (MessagesResponse?) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/Messages/GetMessages?id=\(id)&userID=\(userId)&authkey=\(authkey)") else { return }
        
        NetworkingService.shared.getMessages(url: url) { (json) in
            guard let json = json else {
                completion(nil)
                return }
            do {
                               let response = try MessagesResponse(json: json)
         
                
                               completion(response)
                           } catch {
                            print("Ошибка обработки json")
                            completion(nil)
                           }
                       }
                    }
    //
    // MARK: - Send Message
    //
    static func sendMessage(id: Int, userId: Int, authkey: String,
    text: String, completion: @escaping (SendMessageResponse?) -> Void) {
           guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/Messages/SendMessage") else { return }
        NetworkingService.shared.sendMessage(url: url, id: id, userId: userId, authkey: authkey, text: text, completion:
            { (json) in
            do {
                let response = try SendMessageResponse(json: json as Any)

                if let response = response {
                    completion(response)
                }
                } catch {
                    print("Ошибка обработки json")
                    completion(nil)
                }
            })
        }
    //
    // MARK: - Mark Read Message
    //
    static func markReadMessage(mid: Int, userId: Int, authkey: String,completion: @escaping (SendMessageResponse?) -> Void) {
           guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/Messages/MarkReadMessage") else { return }
        NetworkingService.shared.markReadMessage(url: url, mid: mid, userId: userId, authkey: authkey, completion:
            { (json) in
                guard let json = json else {
                    completion(nil)
                    return }
            do {
                    let response =  try SendMessageResponse(json: json)

                if let response = response {
                    completion(response)
                    
                }
                } catch {
                    print("Ошибка обработки json")
                    completion(nil)
                }
            })
    }
    
    //
    // MARK: - Get User Info
    //
    static func getUserInfo(id: Int, userId: Int, authkey: String,completion: @escaping (UserInfoResponse?) -> Void) {
    guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/Users/GetUserInfo?id=\(id)&userID=\(userId)&authkey=\(authkey)") else { return }
    
    NetworkingService.shared.getUserInfo(url: url) { (json) in
        guard let json = json else {
            completion(nil)
            return }
        do {
                           let response = try UserInfoResponse(json: json)
     
                           completion(response)
                       } catch {
                        print("Ошибка обработки json")
                        completion(nil)
                }
            }
        }
    }


