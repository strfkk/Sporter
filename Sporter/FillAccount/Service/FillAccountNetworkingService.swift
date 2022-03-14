import Foundation

class FillAccountNetworkingService {
private init() {}
    static func fillAccount(age: Int, sportId: String, goalId: String, cityId: String, userId: String, authkey: String, completion: @escaping (FillAccountResponse?) -> Void) {
    guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/register/FillAccount") else { return }
        NetworkingService.shared.fillAccount(url: url, sportId: sportId, goalId: goalId, cityId: cityId, userId: userId, authkey: authkey, age: age, completion:   { (json) in
            guard let json = json else {
                completion(nil)
                return }
                      do {
                        let response =  try FillAccountResponse(json: json)
                              completion(response)
                          } catch {
                            print("Ошибка обработки json")
                            completion(nil)
                          }
                      })
                }
            }

