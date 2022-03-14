import Foundation

class DialogsNetworkingService {
    
    private init() {}
    static func getDialogs(userData: UserData,completion: @escaping (DialogsResponse?) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/Messages/GetDialogs?userID=\(userData.id)&authkey=\(userData.authkey)") else { return }
        
        NetworkingService.shared.getDialogs(url: url) { (json) in
            guard let json = json else {
                completion(nil)
                return }
            do {
                    let response = try DialogsResponse(json: json)
         
                               completion(response)
                           } catch {
                            print("Ошибка обработки json")
                            completion(nil)
                           }
                       }
                    }
                }
