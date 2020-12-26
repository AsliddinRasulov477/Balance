    import UIKit
import RealmSwift

class TAThirdViewController: UIViewController, UITextFieldDelegate {

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
        
        getIndexRowAndSection()
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

    @IBAction func pushRadioButtons(_ sender: DLRadioButton) {
        
        for i in secondRadioButtons.indices {
            if i + 2 == sender.tag {
                secondRadioButtons[i].tintColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
            } else {
                secondRadioButtons[i].tintColor = #colorLiteral(red: 0.9380843043, green: 1, blue: 0.9565529227, alpha: 1)
            }
        }

        if sender.tag == 2 {
            three = "Nachalo perioda"
        } else {
            three = "Kones perioda"
        }

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
        
        for i in secondRadioButtons.indices {
            secondRadioButtons[i].tintColor = #colorLiteral(red: 0.9380843043, green: 1, blue: 0.9565529227, alpha: 1)
        }

        tableView.reloadData()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        editedMoney = textField.text!
    }

}

extension TAThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[indexSection].operationRow[indexRow].pravodki.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAcell", for: indexPath) as! CustomTableViewCell

        cell.firstLabel.text = String(data[indexSection].operationRow[indexRow].pravodki[indexPath.row].split(separator: "Ω")[0])

        if cell.firstLabel.text == "K" {
            cell.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0, blue: 0.1647058824, alpha: 1)
            cell.secondLabel.textColor = #colorLiteral(red: 0.8470588235, green: 0, blue: 0.1647058824, alpha: 1)
        } else {
            cell.layer.borderColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
            cell.secondLabel.textColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
        }

        cell.editTextField.addDoneCancelButtonOnKeyboard(done: UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done)))

        cell.secondLabel.text = String(data[indexSection].operationRow[indexRow].pravodki[indexPath.row].split(separator: "Ω")[1])
        cell.thirdLabel.text = String(data[indexSection].operationRow[indexRow].pravodki[indexPath.row].split(separator: "Ω")[2])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell

        cell.editTextField.becomeFirstResponder()
        cell.editTextField.text = cell.secondLabel.text

        if cell.firstLabel.text == "K" {
            cell.editTextField.textColor = #colorLiteral(red: 0.8470588235, green: 0, blue: 0.1647058824, alpha: 1)
        } else {
            cell.editTextField.textColor = #colorLiteral(red: 0.2, green: 0.768627451, blue: 0.5058823529, alpha: 1)
        }

        cell.editTextField.alpha = 1
        cell.secondLabel.alpha = 0

    }

    @objc func done() {
        let cell = tableView.cellForRow(at: IndexPath(row: tableView.indexPathForSelectedRow!.row, section: tableView.indexPathForSelectedRow!.section)) as! CustomTableViewCell
        cell.editTextField.resignFirstResponder()

        do {
            try realm.write {

                let selectedSchyotData = data[indexSection].operationRow[indexRow].pravodki[tableView.indexPathForSelectedRow!.row].split(separator: "Ω")

                data[indexSection].operationRow[indexRow].pravodki[tableView.indexPathForSelectedRow!.row] = String(selectedSchyotData[0]) + "Ω" + editedMoney + "Ω" + selectedSchyotData[2]
            }
        } catch {
            print(error)
        }

        cell.secondLabel.text = cell.editTextField.text
        cell.editTextField.alpha = 0
        cell.secondLabel.alpha = 1

        tableView.reloadData()
    }
}

extension UITextField {
    func addDoneCancelButtonOnKeyboard(done: UIBarButtonItem) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

}
