import UIKit

class DialogsTableViewCell: UITableViewCell {
    //
    // MARK: - Outlets
    //
       @IBOutlet weak var isReadView: UIView!
       @IBOutlet weak var sendDateLabel: UILabel!
       @IBOutlet weak var dialogsImageView: UIImageView!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var messageLabel: UILabel!
    
}
    //
    // MARK: - Animation
    //
extension DialogsTableViewCell {
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
