import Foundation

class RegisterNetworkingService {
    private init() {}
    static func newUser(phone: String, name: String, password: String, completion: @escaping (newUserResponse?) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/register/NewUser") else { return }
        NetworkingService.shared.newUser(url: url, phone: phone, name: name, password: password) { (json) in
            guard let json = json else {
                completion(nil)
                return }
                    do {
                        let response = try newUserResponse(json: json)
                            completion(response)
                              } catch {
                                print("Ошибка обработки json")
                                completion(nil)
                              }
                          }
                    }
                }

