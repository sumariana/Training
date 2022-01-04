//
//  MultiPickerViewController.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//

import UIKit

struct MultiPickerModel {
    var title: String
    var isSelected: Bool
}

protocol MultiPickerDelegate {
    func selectedItems(items: [String])
}

class MultiPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvLabel: UILabel!
    var items: [MultiPickerModel] = []
    var initialItems : [String] = []
    var dataSource: ProfileDataSource?
    var delegate: MultiPickerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation
        self.navigationItem.title = "Select Hobbies"
        let barButton = UIBarButtonItem(title: "Save".localized, style: .done, target: self, action: #selector(decidePicker))
        barButton.tintColor = ColorCode.green
        self.navigationItem.rightBarButtonItem  = barButton
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
        

        // Do any additional setup after loading the view.
        loadDataSource()
        setData()
        setupView()
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func decidePicker(){
        if delegate != nil {
            self.delegate?.selectedItems(items: getSelectedItems())
            navigationController?.popViewController(animated: true)
        }
//        print(self.getSelectedItems())
    }
    
    func getSelectedItems() -> [String]{
        return items.filter{$0.isSelected}.map{$0.title}
    }
    
    func setData(){
        guard let hobbyArray = dataSource?.hobbyLabel() else {
            return
        }
        for data in hobbyArray {
            var isSelected = false
            if initialItems.contains(data) {
                isSelected = true
            }
            items.append(MultiPickerModel(title: data, isSelected: isSelected))
        }
    }
    
    func setupView(){
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func loadDataSource(){
        if  let path        = Bundle.main.path(forResource: "ProfileList", ofType: "plist"),
            let xml         = FileManager.default.contents(atPath: path),
            let dataSrc = try? PropertyListDecoder().decode(ProfileDataSource.self, from: xml)
        {
            self.dataSource = dataSrc
        }
    }

}

extension MultiPickerViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell") as! MultiPickerTableViewCell
        let item = items[indexPath.row]
        cell.tvLabel.text = item.title
        
        if item.isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected = false
    }
    
    
}
