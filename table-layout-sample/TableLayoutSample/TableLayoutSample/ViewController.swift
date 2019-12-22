//
//  ViewController.swift
//  TableLayoutSample
//
//  Created by 五十嵐稔雄 on 2019/12/22.
//  Copyright © 2019 五十嵐稔雄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var datasource: [BaseType] = [
        BaseType(baseText: "1"),
        BaseType(baseText: "2"),
        BaseType(baseText: "3"),
        BaseType(baseText: "4"),
        BaseType(baseText: "5"),
        BaseType(baseText: "6"),
        BaseType(baseText: "7"),
        BaseType(baseText: "8"),
        BaseType(baseText: "9"),
        BaseType(baseText: "10"),
        BaseType(baseText: "11"),
        BaseType(baseText: "12"),
        BaseType(baseText: "13"),
        BaseType(baseText: "14"),
        BaseType(baseText: "15"),
        BaseType(baseText: "16"),
        BaseType(baseText: "17"),
        BaseType(baseText: "18"),
        BaseType(baseText: "19"),
        BaseType(baseText: "20"),
    ]
    
    @IBOutlet weak var table: UITableView!

    struct BaseType {
        var text: String
        var label: String
        
        init(baseText: String) {
            text = "txt:" + baseText
            label = "label:" + baseText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.dataSource = self
        table.delegate = self
    }

    @IBAction func tapRead(_ sender: Any) {
        
        
        for index in 0 ..< datasource.count {
            let cell = table.cellForRow(at: IndexPath(item: index, section: 0))
            print("cell:\(cell)")
        }

        print("==================")

        for index in 0 ..< datasource.count {
            print("datasource[\(index)]:\(datasource[index])")
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, InputTextTableCellDelegate {
    func textFieldDidEndEditing(cell: BaseCell, value: String) {
        datasource[cell.index].text  = value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "base") as! BaseCell
        
        let index = indexPath.row
        
        cell.label.text = datasource[index].label
        cell.textField.text = datasource[index].text
        cell.index = index
        cell.delegate = self
        
        return cell
    }
}

protocol InputTextTableCellDelegate {
    func textFieldDidEndEditing(cell: BaseCell, value: String) -> ()
}


class BaseCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var index: Int = -1

    var delegate: InputTextTableCellDelegate! = nil
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        self.delegate.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
}

