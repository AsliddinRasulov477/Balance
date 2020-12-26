import UIKit
import RealmSwift

class TAViewController: UIViewController {

    @IBOutlet var mainButtons: [UIButton]!
    
    var data: Results<Database>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in mainButtons.indices {
            mainButtons[i].layer.borderColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            
            mainButtons[i].setBackgroundColor(color: #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1), forUIControlState: .highlighted)
            
            mainButtons[i].layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
            mainButtons[i].layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
            mainButtons[i].layer.shadowOpacity = 4.0
            mainButtons[i].layer.masksToBounds = false
            mainButtons[i].layer.cornerRadius = 10
        }
        
        let sections = PlanSchot().getSections().flatMap { $0 }
        let rows = PlanSchot().getRows()

        data = realm.objects(Database.self)
        
        if data.count == 0 {
            
            for i in sections.indices {
                let newData = Database()
                newData.schyotRows = sections[i]
                for j in rows[i].indices {
                    let ownData = OwnData()
                    ownData.subSchoti = rows[i][j]
                    newData.operationRow.append(ownData)
                }
                do {
                    try realm.write {
                        realm.add(newData)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "const" {
            let sectionNum = [["I"], ["II", "III", "IV", "V"], ["VI", "VII"], ["VIII"]]
            let vc = segue.destination as! TAFirstViewController
            vc.partsArr = sectionNum[Int(segue.identifier!)!]
        }
    }
    
}
extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = self.bounds
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
            
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContext(rect.size)
        
        UIBezierPath(roundedRect: rect, cornerRadius: 15).addClip()
        image?.draw(in: rect)

        image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image!
    }

    func setBackgroundColor(color: UIColor, forUIControlState state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}

