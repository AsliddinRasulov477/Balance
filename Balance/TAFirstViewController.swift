import UIKit

class TAFirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var partsArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TASecondViewController
        var sections: [[String]] = []
        for i in partsArr.indices {
            sections.append(PlanSchot().getSections()[getIndexPart(s: partsArr[i])])
        }
        vc.sections = sections[tableView.indexPathForSelectedRow!.row]
        
        var rows: [[String]] = []
        for i in sections[tableView.indexPathForSelectedRow!.row].indices {
            rows.append(PlanSchot().getRows()[getIndexSection(s: sections[tableView.indexPathForSelectedRow!.row][i])])
        }
        vc.rows = rows
        
    }
    
    func getIndexPart(s: String) -> Int {
        switch s {
        case "I": return 0
        case "II": return 1
        case "III": return 2
        case "IV": return 3
        case "V": return 4
        case "VI": return 5
        case "VII": return 6
        case "VIII": return 7
        default: return -1
        }
        
    }
    
    func getIndexSection(s: String) -> Int {
        let sections = PlanSchot().getSections().flatMap { $0 }
        for i in sections.indices {
            if sections[i] == s {
                return i
            }
        }
        return 0
    }
}


extension TAFirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAcell", for: indexPath) as! CustomTableCell
        cell.numLabel?.text = partsArr[indexPath.row].localized
        return cell
    }
}

