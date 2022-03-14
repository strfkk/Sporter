import Foundation

class EditProfileNetworkingService {
    
    private init() {}
    
    static func editProfile(requestData: RequestData, completion: @escaping (EditProfileResponse?) -> Void)  {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/account/EditAccount") else { return }
        NetworkingService.shared.editProfile(url: url, requestData: requestData)
        { (json) in
            guard let json = json else {
                completion(nil)
                return }
                do {
                        let response = try EditProfileResponse(json: json)
                        completion(response)
                    } catch {
                        print("Ошибка обработки json")
                        completion(nil)
                    }
                }
    }

    static func getPhoto(id: Int, userId:Int, authkey:String,completion: @escaping (Data) -> Void) {
        guard let url = URL(string: "https://sporterapi.azurewebsites.net/api/files/GetImage?userID=\(userId)&authkey=\(authkey)&id=\(id)") else { return }
        print(url)
        
        NetworkingService.shared.getPhoto(url: url) { (data) in

                }
            }
        }

