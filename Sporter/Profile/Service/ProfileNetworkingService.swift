import Foundation

class ProfileNetworkingService {
private init() {}
    static func logout(userId: Int, authkey: String, completion: @escaping (LogoutResponse?) -> Void) {
    guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/login/Logout") else { return }
        NetworkingService.shared.logOut(url: url, userId: userId, authkey: authkey, completion: { (json) in
            guard let json = json else {
                completion(nil)
                return }
        do {
                let response = try LogoutResponse(json: json)
                completion(response)
            
            } catch {
                print("Ошибка обработки json")
                completion(nil)
            }
        })
    }
    static func getphoto(id: Int, userId: Int, authkey: String) {
    guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(userId)&authkey=\(authkey)&id=\(id)") else { return }
        NetworkingService.shared.getPhoto(url: url) { (json) in
            }
        }
    }
