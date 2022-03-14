import UIKit

class NewUserTableViewCell: UITableViewCell {
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func reloadInputViews() {
        inputTextField.text = ""
    }
}
