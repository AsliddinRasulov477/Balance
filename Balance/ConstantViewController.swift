import UIKit

class ConstantViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
        }
    }
}
