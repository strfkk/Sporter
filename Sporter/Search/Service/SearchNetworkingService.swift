import Foundation

class SearchNetworkingService {
    private init() {}
    static func getSearchResult(requestData: SearchRequestData,completion: @escaping (SearchResponse?) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/search/StartSearch?userID=\(requestData.id)&authkey=\(requestData.authkey)&city=\(requestData.city)&sex=0&agemin=0&agemax=40&sport=\(requestData.sport)&goals=\(requestData.goals)")
 
        else { return }

        NetworkingService.shared.getSearchResult(url: url) { (json) in
            guard let json = json else {
                completion(nil)
                return }
            
            do {
                let response = try SearchResponse(json: json)

                               completion(response)
                           } catch {
                            print("Ошибка обработки json")
                            completion(nil)
                           }
                       }
                    }
    static func getphoto(id: Int, userId: Int, authkey: String) {
    guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(userId)&authkey=\(authkey)&id=\(id)") else { return }
        NetworkingService.shared.getPhoto(url: url) { (json) in
        }
            }
                }

