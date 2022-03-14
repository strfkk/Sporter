import Foundation


class NetworkingService {

    private init() {}
    static let shared = NetworkingService()
    
    //
    // MARK: - Get Photo
    //
    public func getPhoto(url: URL, completion: @escaping (Any?)-> ()) {

          let session = URLSession.shared
          session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Ошибка получения data")
                return }
              do {
                  let json = try JSONSerialization.jsonObject(with: data, options: [])
                  DispatchQueue.main.async {
                      completion(json)
                  }
              } catch {
                print("Ошибка кастинга data в json")
                    completion(nil)
              }
          }.resume()
      }
    //
    // MARK: - Set Photo
    //
    
    public func setPhoto(url: URL, userId: Int, file: Data, authkey: String,
                             completion: @escaping (Any?)-> ()) {
         let parameters: [String : Any] = ["userID": userId, "authkey": authkey]
         let myUrl = url

         var request = URLRequest(url: myUrl)
         request.httpMethod = "POST"
         let boundary = generateBoundaryString()
             request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
             request.httpBody = createBodyWithParameters(parameters: parameters as? [String : String], filePathKey: "file", imageDataKey: file as NSData, boundary: boundary, imgKey: "imgKey") as Data
        
         let session = URLSession.shared
           session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                print("Ошибка получения data")
                return }
                       do {
                           let json = try JSONSerialization.jsonObject(with: data, options: [])
                           DispatchQueue.main.async {
                               completion(json)
                           }
                       } catch {
                        
                        print("Ошибка кастинга data в json")
                            completion(nil)
                       }
                   }.resume()
           }
    //
    // MARK: - Get User Info
    //
    public func getUserInfo(url: URL, completion: @escaping (Any?)-> ()) {

              let session = URLSession.shared
              session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print("Ошибка получения data")
                    return }
                  do {
                      let json = try JSONSerialization.jsonObject(with: data, options: [])
                      DispatchQueue.main.async {
                          completion(json)
                      }
                  } catch {
                    print("Ошибка кастинга data в json")
                        completion(nil)
                  }
              }.resume()
          }
    //
    // MARK: - Get Search Result
    //
     public func getSearchResult(url: URL, completion: @escaping (Any?)-> ()) {

           let session = URLSession.shared
           session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Ошибка получения data")
                return }
               do {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])
                   DispatchQueue.main.async {
                       completion(json)
                   }
               } catch {
                print("Ошибка кастинга data в json")
                    completion(nil)

               }
           }.resume()
       }
    //
    // MARK: - Get Dialogs
    //
    public func getDialogs(url: URL, completion: @escaping (Any?)-> ()) {
    
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print("Ошибка получения data")
                    return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    print("Ошибка кастинга data в json")
                        completion(nil)
                }
            }.resume()
        }
    //
    // MARK: - Get Messages
    //
    public func getMessages(url: URL, completion: @escaping (Any?)-> ()) {
        
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print("Ошибка получения data")
                    return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    print("Ошибка кастинга data в json")
                        completion(nil)
                }
            }.resume()
        }
    //
    // MARK: - Send Message
    //
    public func sendMessage(url: URL, id: Int, userId: Int, authkey: String,
                            text: String ,completion: @escaping (Any?)-> ()) {
        
        let parameters: [String : Any] = ["id": id, "userid": userId, "authkey": authkey, "text": text]
        let myUrl = url
        
        var request = URLRequest(url: myUrl)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
           
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { (data, response, error) in

            guard let data = data else {
                print("Ошибка получения data")
                return }
                do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])

                       DispatchQueue.main.async {
                           completion(json)
                       }
                   } catch {
                    print("Ошибка кастинга data в json")
                        completion(nil)
                   }
            }.resume()
        }
    //
    // MARK: - Mark Read Message
    //
    public func markReadMessage(url: URL, mid: Int, userId: Int, authkey: String,
                             completion: @escaping (Any?)-> ()) {
           
           let parameters: [String : Any] = ["mid": mid, "userID": userId, "authkey": authkey]
           let myUrl = url
           
           var request = URLRequest(url: myUrl)
           request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "POST"
           request.httpBody = parameters.percentEncoded()
              
           let session = URLSession.shared
           session.dataTask(with: request as URLRequest) { (data, response, error) in

            guard let data = data else {
                print("Ошибка получения data")
                return }
                   do {
                          let json = try JSONSerialization.jsonObject(with: data, options: [])

                          DispatchQueue.main.async {
                              completion(json)
                          }
                      } catch {
                        print("Ошибка кастинга data в json")
                            completion(nil)
                      }
               }.resume()
           }
    
    //
    // MARK: - New User
    //
    public func newUser(url: URL, phone: String, name: String, password: String, completion: @escaping (Any?)-> ()) {
        
        let parameters: [String : Any] = ["phone": phone, "name": name, "password": password]
         let myUrl = url
        
         var request = URLRequest(url: myUrl)
         request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "POST"
         request.httpBody = parameters.percentEncoded()
        
         let session = URLSession.shared
         session.dataTask(with: request) { (data, response, error) in
 
            guard let data = data else {
                print("Ошибка получения data")
                return }
    
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    print("Ошибка кастинга data в json")
                        completion(nil)
                }
         }.resume()
     }
    //
    // MARK: - Fill Account
    //
    public func fillAccount(url: URL, sportId: String, goalId: String, cityId: String, userId: String, authkey: String, age: Int, completion: @escaping (Any?)-> ()) {
        
        let parameters: [String : Any] = ["sport": sportId, "goals": goalId, "city": cityId,"userID": userId, "authkey": authkey, "age": age]
        let myUrl = url
        var request = URLRequest(url: myUrl)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
           
       let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { (data, response, error) in
    
            guard let data = data else {
                print("Ошибка получения data")
                return }
                   do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                        DispatchQueue.main.async {
                           completion(json)
                       }
                       
                   } catch {
                    print("Ошибка кастинга data в json")
                    completion(nil)
                   }
            }.resume()
        }
    //
    // MARK: - Edit Profile
    //
    public func editProfile(url: URL, requestData: RequestData,  completion: @escaping (Any?)-> ()) {
        
        let parameters: [String : Any] = ["userid": requestData.userId, "authkey": requestData.authkey,"age": requestData.age, "sex": requestData.sex,"sport": requestData.sport, "goals": requestData.goals,"city": requestData.city,"about": requestData.about]
    
        let myUrl = url
      
        var request = URLRequest(url: myUrl)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
    
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
    
            guard let data = data else {
                print("Ошибка получения data")
                return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                                          completion(json)
                                      }
            } catch {
                print("Ошибка кастинга data в json")
                completion(nil)
                    }
                
            }.resume()
        }
    //
    // MARK: - Login
    //
    public func login(url: URL, completion: @escaping (Any?)-> ()) {
    
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Ошибка получения data")
                return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print("Ошибка кастинга data в json")
                    completion(nil)
            }
        }.resume()
    }
    //
    // MARK: - Logout
    //
    public func logOut(url: URL, userId: Int, authkey: String, completion: @escaping (Any?)-> ()) {
        
        let parameters: [String : Any] = ["userid": userId, "authkey": authkey]
        let myUrl = url
        
        var request = URLRequest(url: myUrl)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEncoded()
           
       let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { (data, response, error) in
    
             guard let data = data else {
                print("Ошибка получения data")
                return }
                   do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                        DispatchQueue.main.async {
                           completion(json)
                       }
                       
                   } catch {
                    print("Ошибка кастинга data в json")
                    completion(nil)
                   }
            }.resume()
        }
    
   public func downloadImage(from url: URL, id: Int) -> Data? {
    var dataToReturn: Data?
       print("Download Started")
       getData(from: url) { data, response, error in
           guard let data = data, error == nil else {
            return }
  if let httpResponse = response as? HTTPURLResponse {
    print(httpResponse.statusCode)
     let response: String = "\(httpResponse.statusCode)"
    if response == "200" {
        dataToReturn = data
        } else {
            print(response)
        }
    } else {
        print("error")
        }
         print(response?.description ?? url.lastPathComponent)
         print("Download Finished")
       }
    return dataToReturn
    
   }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        let body = NSMutableData();

        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }

        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpg"

        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")

        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
