import UIKit

class FormaOneFirstViewController: UIViewController, CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let changeCollapsed = !collapsed[section]
        collapsed[section] = changeCollapsed
        tableView.reloadData()
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var rows: [[String]] = []
    var sections: [String] = []
    var senderTag: Int = 0
    var collapsed: [Bool] = []
    
    var startPeriod: [[Int]] = []
    var endPeriod: [[Int]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        for _ in sections.indices {
            collapsed.append(false)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        view.backgroundColor = #colorLiteral(red: 0.8979414105, green: 0.8980956078, blue: 0.8979316354, alpha: 1)
                
        for i in rows.indices {
            var arrStart: [Int] = []
            var arrEnd: [Int] = []
            for row in rows[i] {
                arrStart.append(Balance().balanceRow(row: row)[0])
                arrEnd.append(Balance().balanceRow(row: row)[1])
            }
            startPeriod.append(arrStart)
            endPeriod.append(arrEnd)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FormaOneSecondViewController
        let rowName = rows[tableView.indexPathForSelectedRow!.section][tableView.indexPathForSelectedRow!.row]
        vc.title = rowName
        vc.senderTag = senderTag
        vc.nameSection = findSectionName(rowName: rowName)
    }
    
    func findSectionName(rowName: String) -> String {
        let sectionName = rowName.dropLast(2)
        return sectionName + "00"
    }
}

extension FormaOneFirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections == [] {
            return rows[0].count
        }
        return collapsed[section] ? rows[section].count : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sections == [] {
            return 1
        }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].localized
        if collapsed[section] {
            header.arrowLabel.rotate(.pi / 2)
        } else {
            header.arrowLabel.text = "➤"
        }
        
        header.section = section
        header.delegate = self
        
        header.backgroundColor = .white
        header.clipsToBounds = true
        header.layer.borderWidth = 2
        header.layer.borderColor = #colorLiteral(red: 0.2221309245, green: 0.7983236313, blue: 0.5777897835, alpha: 1)
        header.layer.cornerRadius = 15
        
        return header
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections == [] {
            return 0
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAcell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = rows[indexPath.section][indexPath.row]
        var description = rows[indexPath.section][indexPath.row].localized
        description.removeFirst(5)
        cell.descriptionLabel.text = description
        cell.startSumLabel.text  = "  Начало периода : \(startPeriod[indexPath.section][indexPath.row])"
        cell.endSumLabel.text = "  Конец периода : \(endPeriod[indexPath.section][indexPath.row])"
        if senderTag < 2000 {
            cell.endSumLabel.text = ""
        } else {
            cell.startSumLabel.text = ""
        }
        return cell
    }
}
