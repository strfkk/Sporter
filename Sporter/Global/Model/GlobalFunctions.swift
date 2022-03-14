
import Foundation

public func getTime(date: String) -> String {
           
           let dateFormatter = DateFormatter()
           let createdDate = dateFormatter.date(fromSwapiString: date)!
           let calendar = Calendar.current
           let hour = calendar.component(.hour, from: createdDate)
           let minutes = calendar.component(.minute, from: createdDate)
           let lastMessageTime = String(format:"%02d:%02d", hour, minutes)
           
           return lastMessageTime
       }
public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
       URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   
  
