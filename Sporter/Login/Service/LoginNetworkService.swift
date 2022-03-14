import Foundation

class LoginNetworkService {
    private init() {}
    static func login(phone: String, password: String, completion: @escaping (LoginResponse?) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/login/Login?phone=\(phone)&password=\(password)") else { return }
        NetworkingService.shared.login(url: url) { (json) in
          
            do {
                let response = try LoginResponse(json: json as Any)
                    completion(response)
                } catch {
                    print("Ошибка обработки json")
                    completion(nil)
                    }
                }
            }
        }
