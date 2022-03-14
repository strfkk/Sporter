import UIKit

class searchResultTableViewCell: UITableViewCell {
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //
    // MARK: - Table View Cell
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.07
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 10
        
        cellView.layer.cornerRadius = 12
        avatarImageView.layer.cornerRadius = 12
        avatarImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
    //
    // MARK: - Animation
    //
extension searchResultTableViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
      }
    
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
      }
    
      override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
      }
    
      private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
          UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: animationOptions, animations: {
              self.transform = .init(scaleX: 0.95, y: 0.95)
          }, completion: completion)
        } else {
          UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: animationOptions, animations: {
              self.transform = .identity
          }, completion: completion)
        }
      }
}

