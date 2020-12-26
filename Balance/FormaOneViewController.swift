import UIKit
import RealmSwift

class FormaOneViewController: UIViewController, CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let changeCollapsed = !collapsed[section]
        collapsed[section] = changeCollapsed
        
        tableView.reloadData()
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }

    @IBOutlet weak var tableView: UITableView!
    
    var data: Results<Database>!
    
    var code: [[String]] = []
    var balanceStartPeriod: [[Int]] = []
    var balanceEndPeriod: [[Int]] = []
    
    var rows: [[String]] = []
    var sections: [String] = []
    var collapsed: [Bool] = []
    
    var sectionTitles = ["Актив  I. Узоқ муддатли активлар", "II. Жорий активлар", "Пассив  I. Ўз маблағлари манбалари", "II. Мажбуриятлар"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = #colorLiteral(red: 0.8979414105, green: 0.8980956078, blue: 0.8979316354, alpha: 1)
        
        for _ in sectionTitles.indices {
            collapsed.append(false)
        }
        
        data = realm.objects(Database.self)
        
        tableView.rowHeight = view.frame.height * 0.03
        
        balanceStartPeriod = Balance().getBalance(i: 0)
        balanceEndPeriod = Balance().getBalance(i: 1)
        
        code = SatrKod().getSatrKod()
        
        tableView.tableHeaderView?.backgroundColor = .white
        tableView.reloadData()
    }
    
    func checkSection(tag: Int) {
        sections = []
        rows = []
        
        var schotName: String = ""
        if tag < 2000 {
            if tag < 1100 {
                schotName = "0" + "\(tag - 1000)"
            } else {
                schotName = "\(tag - 1000)"
            }

        } else {
            if tag < 2100 {
                schotName = "0" + "\(tag - 2000)"
            } else {
                schotName = "\(tag - 2000)"
            }

        }
        
        let balanceSchot = BalanceSchot().getBalanceSchot(s: schotName)
    
        for i in data.indices {
            for balanceSection in balanceSchot {
                if data[i].schyotRows == balanceSection {
                    sections.append(data[i].schyotRows)
                    var row: [String] = []
                    for operationRow in data[i].operationRow {
                        row.append(operationRow.subSchoti)
                    }
                    rows.append(row)
                }
            }
        }
        
        if sections.count == 0 {
            rows.append(balanceSchot)
        }
    }
    
    @IBAction func pushStartPeriod(_ sender: UIButton) {
        prepare(tag: sender.tag)
    }
    
    @IBAction func pushEndPeriod(_ sender: UIButton) {
        prepare(tag: sender.tag)
    }
    
    func prepare(tag: Int) {
                
        checkSection(tag: tag)
        
        var schotName: String = ""
        if tag < 2000 {
            if tag < 1100 {
                schotName = "0" + "\(tag - 1000)"
            } else {
                schotName = "\(tag - 1000)"
            }

        } else {
            if tag < 2100 {
                schotName = "0" + "\(tag - 2000)"
            } else {
                schotName = "\(tag - 2000)"
            }

        }
        
        if rows != [[]] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "formaSecond") as! FormaOneFirstViewController
            vc.senderTag = tag
            vc.sections = sections
            vc.rows = rows
    
            navigationController?.show(vc, sender: self)
        } else {
            var alertMassage: String = ""
            switch schotName {
            case "012": alertMassage = "010 - 011"
            case "022": alertMassage = "020 - 021"
            case "030": alertMassage = "040 + 050 + 060 + 070 + 080"
            case "130": alertMassage = "012 + 022 + 030 + 090 + 100 + 110 + 120"
            case "140": alertMassage = "150 + 160 + 170 + 180"
            case "210": alertMassage = "220 + 240 + 250 + 260 + 270 + 280 + 290 + 300 + 310"
            case "211": alertMassage = "Shundan: muddati o'tgan*"
            case "320": alertMassage = "330 + 340 + 350 + 360"
            case "390": alertMassage = "140 + 190 + 200 + 210 + 320 + 370 + 380"
            case "400": alertMassage = "130 + 390"
            case "480": alertMassage = "410 + 420 + 430 - 440 + 450 + 460 + 470"
            case "490": alertMassage = "500 + 520 + 530 + 540 + 550 + 560 + 570 + 580 + 590"
            case "491": alertMassage = "500 + 520 + 540 + 560 + 590"
            case "600": alertMassage = "610 + 630 + 640 + 650 + 660 + 670 + 680 + 690 + 700 + 710 + 720 + 730 + 740 + 750 + 760"
            case "601": alertMassage = "610 + 630 + 650 + 670 + 680 + 690 + 700 + 710 + 720 + 760"
            case "602": alertMassage = "Shundan: muddati o'tgan joriy kreditorlik qarzlari*"
            case "770": alertMassage = "490 + 600"
            case "780": alertMassage = "480 + 770"
                
            default:
                break
            }
            let alertController = UIAlertController(title: "Natija", message: alertMassage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }

    }
}

extension FormaOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collapsed[section] ? code[section].count : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return code.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sectionTitles[section]
        if collapsed[section] {
            header.arrowLabel.rotate(.pi / 2)
        } else {
            header.arrowLabel.text = "➤"
        }
        
        header.section = section
        header.delegate = self
        
        
        return header
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forma1Cell", for: indexPath) as! FormaOneTableViewCell
        cell.firstLabel.text = code[indexPath.section][indexPath.row]
        cell.secondLabel.tag = Int(code[indexPath.section][indexPath.row])! + 1000
        cell.secondLabel.setTitle("\(balanceStartPeriod[indexPath.section][indexPath.row])", for: .normal)
        cell.thirdLabel.tag = Int(code[indexPath.section][indexPath.row])! + 2000
        cell.thirdLabel.setTitle("\(balanceEndPeriod[indexPath.section][indexPath.row])", for: .normal)
        return cell
    }
}
