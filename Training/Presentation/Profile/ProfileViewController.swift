//
//  ProfileViewController.swift
//  timedoorreceipt
//
//  Created by Kevin Raymond on 22/02/19.
//  Copyright © 2019 Kevin Raymond. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: Outlets
    @IBOutlet var etName: UITextField!
    @IBOutlet var tvDOB: UITextField!
    @IBOutlet var tvSex: UITextField!
    @IBOutlet var tvJob: UITextField!
    @IBOutlet var tvArea: UITextField!
    @IBOutlet var tvHobby: UITextField!
    @IBOutlet var tvPersonality: UITextField!
    @IBOutlet var etDesc: UITextView!
    
    var dataSource: ProfileDataSource?
    var userData: ProfileModel?
    
    // MARK: Properties
    
    var presenter: ProfilePresenterProtocol!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProfilePresenter(self)
        presenter.fetchProfile()
        self.navigationItem.title = "Edit Profile"
        let saveBtn = UIBarButtonItem(title: "save".localized, style: .done, target: self, action: #selector(saveForm))
        saveBtn.tintColor = ColorCode.black
        self.navigationItem.rightBarButtonItem  = saveBtn
        tvDOB.datePicker(target: self, doneAction: #selector(selectDate), cancelAction: #selector(cancelDate))
        tvHobby.addTarget(self, action: #selector(openHobbyPicker), for: .editingDidBegin)
        //load data source
        loadDataSource()
    }
    
    @objc func openHobbyPicker(){
        tvHobby.resignFirstResponder()
        let controller = MultiPickerViewController.instantiateStoryboard() as! MultiPickerViewController
        controller.delegate = self
        if tvHobby.text != nil && !tvHobby.text!.isEmpty {
            let list = tvHobby.text!.components(separatedBy : ", ")
            controller.initialItems = list
        }
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    func saveForm(){
        var profileRequest = ProfileRequest()
        profileRequest.nickname = etName.text
        profileRequest.birthday = tvDOB.text
        profileRequest.about_me = etDesc.text
        
        let genderValue = dataSource?.genderValue(gender: tvSex.text)
        profileRequest.gender = Int(genderValue ?? "0")
        
        let personalValue = dataSource?.characterValue(character: tvPersonality?.text ?? "")
        profileRequest.personality = Int(personalValue ?? "0")
        
        let residenceValue = dataSource?.areaValue(area: tvArea?.text ?? "")
        profileRequest.residence = residenceValue
        
        let occupationValue = dataSource?.occupationValue(occupation: tvJob?.text ?? "")
        profileRequest.job = Int(occupationValue ?? "0")
        
        let hobbyValue = dataSource?.hobbyValue(labels: tvHobby.text ?? "")
        profileRequest.hobby = hobbyValue
        
        print(profileRequest)
        onProcess()
        presenter?.editProfile(editProfileRequest: profileRequest)
    }
    
    @objc
    func selectDate(){
        if let datePickerView = self.tvDOB.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd"
                let dateString = dateFormatter.string(from: datePickerView.date)
                self.tvDOB.text = dateString
                self.tvDOB.resignFirstResponder()
            }
    }
    @objc
    func cancelDate(){
        self.tvDOB.resignFirstResponder()
    }
    
    func loadDataSource(){
        if  let path        = Bundle.main.path(forResource: "ProfileList", ofType: "plist"),
            let xml         = FileManager.default.contents(atPath: path),
            let dataSrc = try? PropertyListDecoder().decode(ProfileDataSource.self, from: xml)
        {
            self.dataSource = dataSrc
        }
    }
    
    func setupView(){
        //setup picker
        etName.text = userData?.nickname
        tvDOB.text = userData?.birthday
        
        let genderPicker = UIPickerView()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.tag = PickerType.Gender.hashValue
        let genderIndex = userData?.gender ?? 0
        genderPicker.selectRow(genderIndex, inComponent: 0, animated: false)
        tvSex.inputView = genderPicker
        tvSex.text = dataSource?.genderLabel(gender: String(genderIndex))
        
        let occupationPicker = UIPickerView()
        occupationPicker.dataSource = self
        occupationPicker.delegate = self
        occupationPicker.tag = PickerType.Occupation.hashValue
        let occupationIndex = userData?.job ?? 0
        occupationPicker.selectRow(occupationIndex, inComponent: 0, animated: false)
        tvJob.inputView = occupationPicker
        tvJob.text = dataSource?.occupationLabel(occupation: String(occupationIndex))

        let areaPicker = UIPickerView()
        areaPicker.dataSource = self
        areaPicker.delegate = self
        areaPicker.tag = PickerType.Area.hashValue
        let areaIndex = userData?.residence == nil || userData?.residence == "" ? 0 : Int(userData?.residence ?? "0") ?? 0
        areaPicker.selectRow(areaIndex, inComponent: 0, animated: false)
        tvArea.inputView = areaPicker
        
        let areaKey = userData?.residence == nil || userData?.residence == "" ? String(0) : String(userData?.residence ?? "")
        tvArea.text = dataSource?.areaLabel(area: areaKey)

        let characterPicker = UIPickerView()
        characterPicker.dataSource = self
        characterPicker.delegate = self
        characterPicker.tag = PickerType.Character.hashValue
        tvPersonality.inputView = characterPicker
        tvPersonality.text = dataSource?.characterLabel(character: String(userData?.personality ?? 0))
        
        
        tvHobby.text = dataSource?.hobbyLabel(values: userData?.hobby ?? "")
        
        //tf
        etDesc.text = userData?.aboutMe
    }

}

extension ProfileViewController : MultiPickerDelegate{
    func selectedItems(items: [String]) {
        tvHobby.text = items.joined(separator: ", ")
    }
}

extension ProfileViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case PickerType.Gender.hashValue:
                return (dataSource?.genderLabel().count)!
        case PickerType.Area.hashValue:
            return (dataSource?.areaLabel().count)!
        case PickerType.Occupation.hashValue:
            return (dataSource?.occupationLabel().count)!
        case PickerType.Character.hashValue:
            return (dataSource?.characterLabel().count)!
        default:
            return 0
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        switch pickerView.tag {
        case PickerType.Gender.hashValue:
            tvSex.text = dataSource?.genderLabel()[row]
        case PickerType.Area.hashValue:
            tvArea.text = dataSource?.areaLabel()[row]
        case PickerType.Occupation.hashValue:
            tvJob.text = dataSource?.occupationLabel()[row]
        case PickerType.Character.hashValue:
            tvPersonality.text = dataSource?.characterLabel()[row]
        default: break
            
        }
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case PickerType.Gender.hashValue:
            return dataSource?.genderLabel()[row]
        case PickerType.Area.hashValue:
            return dataSource?.areaLabel()[row]
        case PickerType.Occupation.hashValue:
            return dataSource?.occupationLabel()[row]
        case PickerType.Character.hashValue:
            return dataSource?.characterLabel()[row]
        default:
            return ""
            
        }
    }
}


extension ProfileViewController: ProfileViewProtocol {
    func editProfileResponse(response: EmptyResponse) {
        endProcess()
    }
    
    func deleteAccountResponse() {
        
    }
    
    func buildView(data: ProfileModel) {
        userData = data
        setupView()
    }
    
    func buildError(_ error: ErrorPerResponse?) {
        //showHTTPError(code: error.code)
    }
    
    
}
