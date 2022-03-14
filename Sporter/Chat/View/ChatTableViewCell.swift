
import UIKit

class ChatTableViewCell: UITableViewCell {
    //
    // MARK: - Variables And Properties
    //
    var lightBlueColor = UIColor(red: 0, green: 0.7137, blue: 1, alpha: 1.0) /* #00b6ff */
    var blueColor =     UIColor(red:0.16, green:0.57, blue:0.89, alpha:1.00)
    
    var lightGrayColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
  
        var isComing: Bool! {
            didSet {
                bubleBackgroundView.backgroundColor = isComing ? self.lightGrayColor : self.blueColor
                messageLabel.textColor = isComing ? .black : .white
                
                timeLabel.textColor = isComing ? .gray : self.lightGrayColor

                if (isComing == true){
                    timeLabelTrailingConstraint.isActive = true
                    unreadImage.isHidden = true
                  //  unreadImage.isHidden = true
                    messageLabelLeadingConstraint.isActive = true
                    messageLabelTrailingConstraint.isActive = false
                } else {
                    messageLabelLeadingConstraint.isActive = false
                    messageLabelTrailingConstraint.isActive = true
                    timeLabelTrailingConstraint.isActive = false
                    
                    unreadImage.isHidden = false
                }
            }
        }
        //
        // MARK: - Outlets
        //
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var bubleBackgroundView: UIView!
        @IBOutlet weak var messageLabel: UILabel!
        @IBOutlet weak var messageLabelLeadingConstraint: NSLayoutConstraint!
        @IBOutlet weak var messageLabelTrailingConstraint: NSLayoutConstraint!
        @IBOutlet weak var unreadImage: UIImageView!
        @IBOutlet weak var timeLabelTrailingConstraint: NSLayoutConstraint!
        //
        // MARK: - Table View Cell
        //
        override func awakeFromNib() {
          super.awakeFromNib()
          unreadImage.isHidden = true
          
        }
    }
