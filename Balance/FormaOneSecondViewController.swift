import UIKit
import RealmSwift

class FormaOneSecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet var firstRadioButtons: [DLRadioButton]!
    @IBOutlet var secondRadioButtons: [DLRadioButton]!

    var data: Results<Database>!

    var nameSection: String = ""
    var indexSection: Int = 0
    var indexRow: Int = 0

    var one: String = ""
    var two: String = ""
    var three: String = ""
    var four: String = ""

    var editedMoney = ""
    
    var senderTag: Int = 0
    var typeArrayPeriod: [String] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.addDoneCancelButtonOnKeyboard(done: UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(addMoney)))

        data = realm.objects(Database.self)
        
        for i in firstRadioButtons.indices {
            firstRadioButtons[i].isSelected = true
            firstRadioButtons[i].tintColor = #colorLiteral(red: 0.9380843043, green: 1, blue: 0.9565529227, alpha: 1)

            secondRadioButtons[i].isSelected = true
            secondRadioButtons[i].tintColor = #colorLiteral(red: 0.9380843043, green: 1, blue: 0.9565529227, alpha: 1)
        }
        
        if Int(title!)! < 6000 {
            firstRadioButtons[0].tintColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            one = "D"
        } else {
            firstRadioButtons[1].tintColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            one = "K"
        }
        
        if senderTag < 2000 {
            secondRadioButtons[0].tintColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            three = "Nachalo perioda"
        } else {
            secondRadioButtons[1].tintColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            three = "Kones perioda"
        }
        
        getIndexRowAndSection()
        
        for pravodka in data[indexSection].operationRow[indexRow].pravodki {
            if senderTag < 2000 {
                if pravodka.split(separator: "Ω").last == "Nachalo perioda" {
                    typeArrayPeriod.append(pravodka)
                }
            } else {
                if pravodka.split(separator: "Ω").last == "Kones perioda" {
                    typeArrayPeriod.append(pravodka)
                }
            }
        }
        
    }
    
    func getIndexRowAndSection() {
        for i in data.indices {
            if data[i].schyotRows == nameSection {
                indexSection = i
                break
            }
        }
        for i in data[indexSection].operationRow.indices {
            if data[indexSection].operationRow[i].subSchoti == title {
                indexRow = i
                break
            }
        }
    }

    @objc func addMoney() {
        textField.resignFirstResponder()
    }

    @IBAction func savePravodka(_ sender: UIButton) {

        do {
            try realm.write {
                two = textField.text ?? ""
                data[indexSection].operationRow[indexRow].pravodki.append(one + "Ω" + two + "Ω" + three)
            }
        } catch {
            print(error)
        }

        textField.text = ""
        
        typeArrayPeriod = []
        data = realm.objects(Database.self)
        
        for pravodka in data[indexSection].operationRow[indexRow].pravodki {
            if senderTag < 2000 {
                if pravodka.split(separator: "Ω").last == "Nachalo perioda" {
                    typeArrayPeriod.append(pravodka)
                }
            } else {
                if pravodka.split(separator: "Ω").last == "Kones perioda" {
                    typeArrayPeriod.append(pravodka)
                }
            }
        }
        
        tableView.reloadData()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        editedMoney = textField.text!
    }

}

extension FormaOneSecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArrayPeriod.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAcell", for: indexPath) as! CustomTableViewCell

        cell.firstLabel.text = String(typeArrayPeriod[indexPath.row].split(separator: "Ω")[0])

        if cell.firstLabel.text == "K" {
            cell.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0, blue: 0.1647058824, alpha: 1)
            cell.secondLabel.textColor = #colorLiteral(red: 0.8470588235, green: 0, blue: 0.1647058824, alpha: 1)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
            cell.secondLabel.textColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
        }

        cell.secondLabel.text = String(typeArrayPeriod[indexPath.row].split(separator: "Ω")[1])
        
        cell.thirdLabel.text = String(typeArrayPeriod[indexPath.row].split(separator: "Ω")[2])

        return cell
    }
}
