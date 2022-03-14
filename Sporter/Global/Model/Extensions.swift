

import Foundation
import  UIKit
extension UIViewController {
    func displayMessage(userMessage:String)  {
    DispatchQueue.main.async
        {
            let alertController = UIAlertController(title: nil, message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Oк", style: .default) { (action:UIAlertAction!) in
                self.view.activityStopAnimating()
                self.viewDidLoad()
                // Code in this block will trigger when OK button tapped.
              
                DispatchQueue.main.async
                    {
                        print("Ok button tapped")
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
}
extension UIView{

 func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
    let backgroundView = UIView()
    backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    backgroundView.backgroundColor = backgroundColor
    backgroundView.tag = 475647

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.center = self.center
    activityIndicator.hidesWhenStopped = true
    if #available(iOS 13.0, *) {
        activityIndicator.style = UIActivityIndicatorView.Style.medium
    } else {
        // Fallback on earlier versions
    }
    activityIndicator.color = activityColor
    activityIndicator.startAnimating()
    self.isUserInteractionEnabled = false

    backgroundView.addSubview(activityIndicator)

    self.addSubview(backgroundView)
}

func activityStopAnimating() {
    if let background = viewWithTag(475647){
        background.removeFromSuperview()
    }
    self.isUserInteractionEnabled = true
}
}

extension UITableView {
    func scrollToBottomRow() {
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else { return }

            // Make an attempt to use the bottom-most section with at least one row
            var section = max(self.numberOfSections - 1, 0)
            var row = max(self.numberOfRows(inSection: section) - 1, 0)
            var indexPath = IndexPath(row: row, section: section)

            // Ensure the index path is valid, otherwise use the section above (sections can
            // contain 0 rows which leads to an invalid index path)
            while !self.indexPathIsValid(indexPath) {
                section = max(section - 1, 0)
                row = max(self.numberOfRows(inSection: section) - 1, 0)
                indexPath = IndexPath(row: row, section: section)

                // If we're down to the last section, attempt to use the first row
                if indexPath.section == 0 {
                    indexPath = IndexPath(row: 0, section: 0)
                    break
                }
            }

            // In the case that [0, 0] is valid (perhaps no data source?), ensure we don't encounter an
            // exception here
            guard self.indexPathIsValid(indexPath) else { return }
           
        
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
        }
    }

    func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
}
extension EditProfileViewController {
    func setPhoto(image: UIImage, userId: Int, authkey: String) {
    
      let image = image.pngData()
         //  guard let image = tmpImage else { return  }

           let filename = "avatar.png"

           // generate boundary string using a unique per-app string
           let boundary = UUID().uuidString

           let fieldName = "userID"
           let fieldValue = String(userId)

           let fieldName2 = "authkey"
           let fieldValue2 = authkey
         
         
         let config = URLSessionConfiguration.default
         let session = URLSession(configuration: config)

         // Set the URLRequest to POST and to the specified URL
         var urlRequest = URLRequest(url: URL(string: "https://sporterapi.azurewebsites.net/api/files/UploadImage")!)
         urlRequest.httpMethod = "POST"

         // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
         // And the boundary is also set here
         urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

         var data = Data()

         // Add the reqtype field and its value to the raw http request data
         data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
         data.append("\(fieldValue)".data(using: .utf8)!)

         // Add the userhash field and its value to the raw http reqyest data
         data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         data.append("Content-Disposition: form-data; name=\"\(fieldName2)\"\r\n\r\n".data(using: .utf8)!)
         data.append("\(fieldValue2)".data(using: .utf8)!)

         // Add the image data to the raw http request data
         data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
         data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
         data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
      data.append(image!)

         // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
         // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
         data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

         // Send a POST request to the URL, with the data we created earlier
         session.uploadTask(with: urlRequest, from: data, completionHandler: { (responseData, response, error) in
               
             if(error != nil){
                 print("\(error!.localizedDescription)")
             }
             
             guard let responseData = responseData else {
                 print("no response data")
                 return
             }
            do {
                let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                if let dict = dict {
                     let resp = try SetPhotoResponse(dict: dict)
                    if resp.errorCode == "c0" {
                        self.isPhotoEdited = false
                     DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
            
                    } else {
                        print("error")
                    }
                }
               
            } catch {
                print(error.localizedDescription)
            }
              
             if let responseString = String(data: responseData, encoding: .utf8) {
                 print("uploaded to: \(responseString)")
        
                
             }
            
         }).resume()
       
     }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension DateFormatter {
    func date(fromSwapiString dateString: String) -> Date? {
        // SWAPI dates look like: "2014-12-10T16:44:31.486000"
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
}

extension UIViewController {
    func createMessageLabel(text: String ) -> (UILabel){
       
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.6, height: view.frame.height * 0.05))
    messageLabel.backgroundColor = UIColor.gray // just for test, to make it visible
    messageLabel.textColor = UIColor.white
    messageLabel.font = messageLabel.font.withSize(14)
    messageLabel.center = view.center
    messageLabel.text = text
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 0
    messageLabel.layer.masksToBounds = true
    messageLabel.layer.cornerRadius = 10
     return messageLabel
       
   }
    
    func reload(tableView: UITableView) {

        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset, animated: false)

    }
}
