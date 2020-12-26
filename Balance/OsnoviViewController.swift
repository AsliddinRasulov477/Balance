//
//  OsnoviViewController.swift
import UIKit

class OsnoviViewController: UIViewController {

    @IBOutlet weak var firstPickerView: UIPickerView!
    @IBOutlet weak var secondPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
}

extension OsnoviViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "First \(row)"
    }
    
}
