
import UIKit

class Cell1TableViewCell: UITableViewCell {
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var editPrifileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var showFullInfoButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //
    // MARK: - Table View Cell
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
         editPrifileButton.layer.cornerRadius = 25
         logoutButton.layer.cornerRadius = 25
         logoutButton.layer.borderWidth = 1
         logoutButton.layer.borderColor = UIColor.black.cgColor
         showFullInfoButton.tintColor = .lightGray
    }
}
