import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
        layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        } set (newFrame) {
            var frame = newFrame
            frame.origin.x += 10
            frame.size.width -= 20
            frame.origin.y += 5
            frame.size.height -= 10
            super.frame = frame
        }
    }
    
}

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startSumLabel: UILabel!
    @IBOutlet weak var endSumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
        
        numLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        if descriptionLabel != nil {
            descriptionLabel.layer.maskedCorners = [.layerMaxXMinYCorner]
        }
        if endSumLabel != nil {
            endSumLabel.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
    }

    override var frame: CGRect {
        get {
            return super.frame
        } set (newFrame) {
            var frame = newFrame
            frame.origin.y += 5
            frame.size.height -= 10
            super.frame = frame
        }
    }
}


class FormaOneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UIButton!
    @IBOutlet weak var thirdLabel: UIButton!
    
}


class CollapsibleTableViewCell: UITableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 5
            frame.size.height -= 10
            
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        textLabel?.numberOfLines = 0
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
