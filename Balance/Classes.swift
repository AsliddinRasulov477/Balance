import Foundation
import RealmSwift


class Database: Object {
    @objc dynamic var schyotRows: String = ""
    var operationRow = List<OwnData>()
    convenience init(schyotRow: String, operationRow: OwnData) {
        self.init()
        self.schyotRows = schyotRow
        self.operationRow.append(operationRow)
    }
}

class OwnData: Object {
    @objc dynamic var subSchoti: String = ""
    var pravodki = List<String>()
    
    convenience init(subSchot: String, pravodka: String) {
        self.init()
        self.subSchoti = subSchot
        self.pravodki.append(pravodka)
    }
}

class SatrKod {
    func getSatrKod() -> [[String]] {
        var satrKod: [[String]] = []
        satrKod = [["010", "011", "012", "020", "021", "022", "030", "040", "050", "060", "070", "080", "090", "100", "110", "120", "130"], ["140", "150", "160", "170", "180", "190", "200", "210", "211", "220", "230", "240", "250", "260", "270", "280", "290", "300", "310", "320", "330", "340", "350", "360", "370", "380", "390", "400"], ["410", "420", "430", "440", "450", "460", "470", "480"], ["490", "491", "500", "510", "520", "530", "540", "550", "560", "570", "580", "590", "600", "601", "602", "610", "620", "630", "640", "650", "660", "670", "680", "690", "700", "710", "720", "730", "740", "750", "760", "770", "780"]]
        return satrKod
    }
}

class PlanSchot {
    func getSections() -> [[String]] {
        var sections: [[String]] = []
    
        sections = [["0100", "0200", "0300", "0400", "0500", "0600", "0700", "0800", "0900"], ["1000", "1100", "1500", "1600", "2000", "2100", "2300", "2500", "2600", "2700", "2800", "2900"], ["3100", "3200"], ["4000", "4100", "4200", "4300", "4400", "4500", "4600", "4700", "4800", "4900"], ["5000", "5100", "5200", "5500", "5600", "5700", "5800", "5900"], ["6000", "6100", "6200", "6300", "6400", "6500", "6600", "6700", "6800", "6900"], ["7000", "7100", "7200", "7300", "7800", "7900"], ["8300", "8400", "8500", "8600", "8700", "8800", "8900"]]
        return sections
    }
    
    func getRows() -> [[String]] {
        var rows: [[String]] = []
    
        rows = [["0110", "0111", "0112", "0120", "0130", "0140", "0150", "0160", "0170", "0180", "0190", "0199"], ["0211", "0212", "0220", "0230", "0240", "0250", "0260", "0270", "0280", "0290", "0299"], ["0310"], ["0410", "0420", "0430", "0440", "0450", "0460", "0470", "0480", "0490"], ["0510", "0520", "0530", "0540", "0560", "0570", "0590"], ["0610", "0620", "0630", "0640", "0690"], ["0710", "0720"], ["0810", "0820", "0830", "0840", "0850", "0860", "0890"], ["0910", "0920", "0930", "0940", "0950", "0960", "0990"], ["1010", "1020", "1030", "1040", "1050", "1060", "1070", "1080", "1090"], ["1110", "1120"], ["1510"], ["1610"], ["2010"], ["2110"], ["2310"], ["2510"], ["2610"], ["2710"], ["2810", "2820", "2830"], ["2910", "2920", "2930", "2940", "2950", "2960", "2970", "2980", "2990"], ["3110", "3120", "3190"], ["3210", "3220", "3290"], ["4010", "4020"], ["4110", "4120"], ["4210", "4220", "4230", "4290"], ["4310", "4320", "4330"], ["4410"], ["4510", "4520"], ["4610"], ["4710", "4720", "4730", "4790"], ["4810", "4820", "4830", "4840", "4850", "4860", "4890"], ["4910"], ["5010", "5020"], ["5110"], ["5210", "5220"], ["5510", "5520", "5530"], ["5610"], ["5710"], ["5810", "5830", "5890"], ["5910", "5920"], ["6010", "6020"], ["6110", "6120"], ["6210", "6220", "6230", "6240", "6250", "6290"], ["6310", "6320", "6390"], ["6410"], ["6510", "6520"], ["6610", "6620", "6630"], ["6710", "6720"], ["6810", "6820", "6830", "6840"], ["6910", "6920", "6930", "6940", "6950", "6960", "6970", "6990"], ["7010", "7020"], ["7110", "7120"], ["7210", "7220", "7230", "7240", "7250", "7290"], ["7310"], ["7810", "7820", "7830", "7840"], ["7910", "7920"], ["8310", "8320", "8330"], ["8410", "8420"], ["8510", "8520", "8530"], ["8610", "8620"], ["8710", "8720"], ["8810", "8820", "8830", "8840", "8890"], ["8910"]]
        return rows
    }
    
}

class Balance {
    
    var sectionBalance: [[Int]] = []
    var rowBalance: [Int] = []
    
    var data: Results<Database>!
    
    func getBalance(i: Int) -> [[Int]] {
        rowBalance.append(balanceSection(section: "0100")[i] + balanceSection(section: "0300")[i]) //010
        rowBalance.append(balanceSection(section: "0200")[i]) //011
        rowBalance.append(rowBalance[0] - rowBalance[1]) //012
        rowBalance.append(balanceSection(section: "0400")[i]) //020
        rowBalance.append(balanceSection(section: "0500")[i]) //021
        rowBalance.append(rowBalance[3] - rowBalance[4]) //022
        rowBalance.append(balanceRow(row: "0610")[i] + balanceRow(row: "0620")[i] + balanceRow(row: "0630")[i] + balanceRow(row: "0640")[i] + balanceRow(row: "0690")[i]) //030
        rowBalance.append(balanceRow(row: "0610")[i]) //040
        rowBalance.append(balanceRow(row: "0620")[i]) //050
        rowBalance.append(balanceRow(row: "0630")[i]) //060
        rowBalance.append(balanceRow(row: "0640")[i]) //070
        rowBalance.append(balanceRow(row: "0690")[i]) //080
        rowBalance.append(balanceSection(section: "0700")[i]) //090
        rowBalance.append(balanceSection(section: "0800")[i]) //100
        rowBalance.append(balanceRow(row: "0910")[i] + balanceRow(row: "0920")[i] + balanceRow(row: "0930")[i] + balanceRow(row: "0940")[i]) //110
        rowBalance.append(balanceRow(row: "0950")[i] + balanceRow(row: "0960")[i] + balanceRow(row: "0990")[i]) //120
        rowBalance.append(rowBalance[2] + rowBalance[5] + rowBalance[6] + rowBalance[12] + rowBalance[13] + rowBalance[15]) //130
        
        sectionBalance.append(rowBalance)
        rowBalance = []
        
        rowBalance.append(balanceSection(section: "1000")[i] + balanceSection(section: "1100")[i] + balanceSection(section: "1500")[i] + balanceSection(section: "1600")[i] + balanceSection(section: "2000")[i] + balanceSection(section: "2100")[i] + balanceSection(section: "2300")[i] + balanceSection(section: "2700")[i] + balanceSection(section: "2800")[i] + balanceSection(section: "2900")[i] - balanceRow(row: "2980")[i]) //140
        rowBalance.append(balanceSection(section: "1000")[i] + balanceSection(section: "1100")[i] + balanceSection(section: "1500")[i] + balanceSection(section: "1600")[i]) //150
        rowBalance.append(balanceSection(section: "2000")[i] + balanceSection(section: "2100")[i] + balanceSection(section: "2300")[i] + balanceSection(section: "2700")[i]) //160
        rowBalance.append(balanceSection(section: "2800")[i]) //170
        rowBalance.append(balanceSection(section: "2900")[i] - balanceRow(row: "2980")[i]) //180
        rowBalance.append(balanceSection(section: "3100")[i]) //190
        rowBalance.append(balanceSection(section: "3200")[i]) //200
        rowBalance.append(balanceSection(section: "4000")[i] - balanceRow(row: "4900")[i] + balanceRow(row: "4120")[i] + balanceSection(section: "4200")[i] + balanceSection(section: "4300")[i] + balanceSection(section: "4400")[i] + balanceSection(section: "4500")[i] + balanceSection(section: "4600")[i] + balanceSection(section: "4700")[i] + balanceSection(section: "4800")[i]) //210
        rowBalance.append(0) //211
        rowBalance.append(balanceSection(section: "4000")[i] - balanceRow(row: "4900")[i]) //220
        rowBalance.append(balanceRow(row: "4110")[i]) //230
        rowBalance.append(balanceRow(row: "4120")[i]) //240
        rowBalance.append(balanceSection(section: "4200")[i]) //250
        rowBalance.append(balanceSection(section: "4300")[i]) //260
        rowBalance.append(balanceSection(section: "4400")[i]) //270
        rowBalance.append(balanceSection(section: "4500")[i]) //280
        rowBalance.append(balanceSection(section: "4600")[i]) //290
        rowBalance.append(balanceSection(section: "4700")[i]) //300
        rowBalance.append(balanceSection(section: "4800")[i]) //310
        rowBalance.append(balanceSection(section: "5000")[i] + balanceSection(section: "5100")[i] + balanceSection(section: "5200")[i] + balanceSection(section: "5500")[i] + balanceSection(section: "5600")[i] + balanceSection(section: "5700")[i]) //320
        rowBalance.append(balanceSection(section: "5000")[i]) //330
        rowBalance.append(balanceSection(section: "5100")[i]) //340
        rowBalance.append(balanceSection(section: "5200")[i]) //350
        rowBalance.append(balanceSection(section: "5500")[i] + balanceSection(section: "5600")[i] + balanceSection(section: "5700")[i]) //360
        rowBalance.append(balanceSection(section: "5800")[i]) //370
        rowBalance.append(balanceSection(section: "5900")[i]) //380
        rowBalance.append(rowBalance[0] + rowBalance[5] + rowBalance[6] + rowBalance[7] + rowBalance[9] + rowBalance[24] + rowBalance[25]) //390
        rowBalance.append(sectionBalance[0][16] + rowBalance[26]) //400
        
        sectionBalance.append(rowBalance)
        rowBalance = []
        
        rowBalance.append(balanceSection(section: "8300")[i]) //410
        rowBalance.append(balanceSection(section: "8400")[i]) //420
        rowBalance.append(balanceSection(section: "8500")[i]) //430
        rowBalance.append(balanceSection(section: "8600")[i]) //440
        rowBalance.append(balanceSection(section: "8700")[i]) //450
        rowBalance.append(balanceSection(section: "8800")[i]) //460
        rowBalance.append(balanceSection(section: "8900")[i]) //470
        rowBalance.append(balanceSection(section: "8300")[i] + balanceSection(section: "8400")[i] + balanceSection(section: "8500")[i] - balanceSection(section: "8600")[i] + balanceSection(section: "8700")[i] + balanceSection(section: "8800")[i] + balanceSection(section: "8900")[i]) //480
        
        sectionBalance.append(rowBalance)
        rowBalance = []
        
        rowBalance.append(balanceSection(section: "7000")[i] + balanceRow(row: "7120")[i] + balanceRow(row: "7210")[i] + balanceRow(row: "7220")[i] + balanceRow(row: "7230")[i] + balanceRow(row: "7240")[i] + balanceRow(row: "7250")[i] + balanceRow(row: "7290")[i] + balanceSection(section: "7300")[i] + balanceRow(row: "7810")[i] + balanceRow(row: "7820")[i] + balanceRow(row: "7830")[i] + balanceRow(row: "7840")[i] + balanceSection(section: "7900")[i]) //490
        rowBalance.append(balanceSection(section: "7000")[i] + balanceRow(row: "7120")[i] + balanceRow(row: "7240")[i] + balanceSection(section: "7300")[i] + balanceSection(section: "7900")[i]) //491
        rowBalance.append(balanceSection(section: "7000")[i]) //500
        rowBalance.append(balanceRow(row: "7110")[i]) //510
        rowBalance.append(balanceRow(row: "7120")[i]) //520
        rowBalance.append(balanceRow(row: "7210")[i] + balanceRow(row: "7220")[i] + balanceRow(row: "7230")[i]) //530
        rowBalance.append(balanceRow(row: "7240")[i]) //540
        rowBalance.append(balanceRow(row: "7250")[i] + balanceRow(row: "7290")[i]) //550
        rowBalance.append(balanceSection(section: "7300")[i]) //560
        rowBalance.append(balanceRow(row: "7810")[i]) //570
        rowBalance.append(balanceRow(row: "7820")[i] + balanceRow(row: "7830")[i] + balanceRow(row: "7840")[i]) //580
        rowBalance.append(balanceSection(section: "7900")[i]) //590
        rowBalance.append(balanceSection(section: "6000")[i] + balanceRow(row: "6120")[i] + balanceRow(row: "6210")[i] + balanceRow(row: "6220")[i] + balanceRow(row: "6230")[i] + balanceRow(row: "6240")[i] + balanceRow(row: "6250")[i] + balanceRow(row: "6290")[i] + balanceSection(section: "6300")[i] + balanceSection(section: "6400")[i] + balanceRow(row: "6510")[i] + balanceRow(row: "6520")[i] + balanceSection(section: "6600")[i] + balanceSection(section: "6700")[i] + balanceRow(row: "6810")[i] + balanceRow(row: "6820")[i] + balanceRow(row: "6830")[i] + balanceRow(row: "6840")[i] + balanceSection(section: "6900")[i]) //600
        rowBalance.append(balanceSection(section: "6000")[i] + balanceRow(row: "6120")[i] + balanceRow(row: "6240")[i] + balanceSection(section: "6300")[i] + balanceSection(section: "6400")[i] + balanceRow(row: "6510")[i] + balanceRow(row: "6520")[i] + balanceSection(section: "6600")[i] + balanceSection(section: "6700")[i] + balanceSection(section: "6900")[i] - balanceRow(row: "6950")[i]) //601
        rowBalance.append(0) //602
        rowBalance.append(balanceSection(section: "6000")[i]) //610
        rowBalance.append(balanceRow(row: "6110")[i]) //620
        rowBalance.append(balanceRow(row: "6120")[i]) //630
        rowBalance.append(balanceRow(row: "6210")[i] + balanceRow(row: "6220")[i] + balanceRow(row: "6230")[i]) //640
        rowBalance.append(balanceRow(row: "6240")[i]) //650
        rowBalance.append(balanceRow(row: "6250")[i] + balanceRow(row: "6290")[i]) //660
        rowBalance.append(balanceSection(section: "6300")[i]) //670
        rowBalance.append(balanceSection(section: "6400")[i]) //680
        rowBalance.append(balanceRow(row: "6510")[i]) //690
        rowBalance.append(balanceRow(row: "6520")[i]) //700
        rowBalance.append(balanceSection(section: "6600")[i]) //710
        rowBalance.append(balanceSection(section: "6700")[i]) //720
        rowBalance.append(balanceRow(row: "6810")[i]) //730
        rowBalance.append(balanceRow(row: "6820")[i] + balanceRow(row: "6830")[i] + balanceRow(row: "6840")[i]) //740
        rowBalance.append(balanceRow(row: "6950")[i]) //750
        rowBalance.append(balanceSection(section: "6900")[i] - balanceRow(row: "6950")[i]) //760
        rowBalance.append(rowBalance[0] + rowBalance[12]) //770
        rowBalance.append(sectionBalance[2][7] + rowBalance[31]) //780
        
        sectionBalance.append(rowBalance)
        rowBalance = []
        
        return sectionBalance
    }
    
    func balanceSection(section: String) -> [Int] {
        data = realm.objects(Database.self)
        var pravodkiSection: [String] = []
        
        for i in data.indices {
            if data[i].schyotRows == section {
                for j in data[i].operationRow.indices {
                    pravodkiSection.append(contentsOf: data[i].operationRow[j].pravodki)
                }
            }
        }
        
        var startPerioda: Int = 0
        var endPerioda: Int = 0
        
        for i in pravodkiSection.indices {
            let splitPravodkiSection = pravodkiSection[i].split(separator: "Ω")
            if String(splitPravodkiSection[2]) == "Nachalo perioda" {
                if String(splitPravodkiSection[0]) == "D" {
                    startPerioda += Int(String(splitPravodkiSection[1]))!
                } else {
                    startPerioda -= Int(String(splitPravodkiSection[1]))!
                }
            } else {
                if String(splitPravodkiSection[0]) == "D" {
                    endPerioda += Int(String(splitPravodkiSection[1]))!
                } else {
                    endPerioda -= Int(String(splitPravodkiSection[1]))!
                }
            }
        }
        
        return [startPerioda, endPerioda]
    }
    
    func balanceRow(row: String) -> [Int] {
        data = realm.objects(Database.self)
        var pravodkiRow: [String] = []
        
        for i in data.indices {
            for j in data[i].operationRow.indices {
                if data[i].operationRow[j].subSchoti == row {
                    pravodkiRow.append(contentsOf: data[i].operationRow[j].pravodki)
                }
            }
        }
        
        var startPerioda: Int = 0
        var endPerioda: Int = 0
        
        for i in pravodkiRow.indices {
            let splitPravodkiRow = pravodkiRow[i].split(separator: "Ω")
            if String(splitPravodkiRow[2]) == "Nachalo perioda" {
                if String(splitPravodkiRow[0]) == "D" {
                    startPerioda += Int(String(splitPravodkiRow[1]))!
                } else {
                    startPerioda -= Int(String(splitPravodkiRow[1]))!
                }
            } else {
                if String(splitPravodkiRow[0]) == "D" {
                    endPerioda += Int(String(splitPravodkiRow[1]))!
                } else {
                    endPerioda -= Int(String(splitPravodkiRow[1]))!
                }
            }
        }
        
        return [startPerioda, endPerioda]
    }
}



class BalanceSchot {
    func getBalanceSchot(s: String) -> [String] {
        switch s {
        case "010": return ["0100", "0300"]
        case "011": return ["0200"]
        case "012": return []
        case "020": return ["0400"]
        case "021": return ["0500"]
        case "022": return []
        case "030": return []
        case "040": return ["0610"]
        case "050": return ["0620"]
        case "060": return ["0630"]
        case "070": return ["0640"]
        case "080": return ["0690"]
        case "090": return ["0700"]
        case "100": return ["0800"]
        case "110": return ["0910", "0920", "0930", "0940"]
        case "120": return ["0950", "0960", "0990"]
        case "130": return []
        case "140": return []
        case "150": return ["1000", "1100", "1500", "1600"]
        case "160": return ["2000", "2100", "2300", "2700"]
        case "170": return ["2800"]
        case "180": return ["2900"]
        case "190": return ["3100"]
        case "200": return ["3200"]
        case "210": return []
        case "211": return []
        case "220": return ["4000", "4900"]
        case "230": return ["4110"]
        case "240": return ["4120"]
        case "250": return ["4200"]
        case "260": return ["4300"]
        case "270": return ["4400"]
        case "280": return ["4500"]
        case "290": return ["4600"]
        case "300": return ["4700"]
        case "310": return ["4800"]
        case "320": return []
        case "330": return ["5000"]
        case "340": return ["5100"]
        case "350": return ["5200"]
        case "360": return ["5500", "5600", "5700"]
        case "370": return ["5800"]
        case "380": return ["5900"]
        case "390": return []
        case "400": return []
        case "410": return ["8300"]
        case "420": return ["8400"]
        case "430": return ["8500"]
        case "440": return ["8600"]
        case "450": return ["8700"]
        case "460": return ["8800"]
        case "470": return ["8900"]
        case "480": return []
        case "490": return []
        case "491": return []
        case "500": return ["7000"]
        case "510": return ["7110"]
        case "520": return ["7120"]
        case "530": return ["7210", "7220", "7230"]
        case "540": return ["7240"]
        case "550": return ["7250", "7290"]
        case "560": return ["7300"]
        case "570": return ["7810"]
        case "580": return ["7820", "7830", "7840"]
        case "590": return ["7900"]
        case "600": return []
        case "601": return []
        case "602": return []
        case "610": return ["6000"]
        case "620": return ["6110"]
        case "630": return ["6120"]
        case "640": return ["6210", "6220", "6230"]
        case "650": return ["6240"]
        case "660": return ["6250", "6290"]
        case "670": return ["6300"]
        case "680": return ["6400"]
        case "690": return ["6510"]
        case "700": return ["6520"]
        case "710": return ["6600"]
        case "720": return ["6700"]
        case "730": return ["6810"]
        case "740": return ["6820", "6830", "6840"]
        case "750": return ["6950"]
        case "760": return ["6900"]
        case "770": return []
        case "780": return []
            
        default: break
        }
        return [""]
    }
}
