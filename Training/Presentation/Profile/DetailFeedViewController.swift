//
//  DetailFeedViewController.swift
//  Training
//
//  Created by TimedoorMSI on 08/12/21.
//

import UIKit

class DetailFeedViewController:  UIViewController {

    var userId: Int = 0
    var userImage: UIImage? = nil
    
    @IBOutlet var profileImageView: UIImageView!{
        didSet{
            profileImageView.image = userImage
        }
    }
    @IBOutlet var aboutMeTextView: UITextView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var ageContent: UIStackView!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var occupancyLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var areaContent: UIStackView!
    @IBOutlet var hobbyLabel: UILabel!
    @IBOutlet var hobbyContent: UIStackView!
    @IBOutlet var characterLabel: UILabel!
    @IBOutlet var sendMessageButton: UIButton!
    
    var presenter: ProfilePresenter!
    var imageUrl = ""
    var targetUser: ProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail Feed"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closePage))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.systemBlue
            
        
        presenter = ProfilePresenter(self)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func closePage() {
       dismiss(animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        onProcess()
        presenter.fetchProfile(userId: userId)
    }
    
    @IBAction func openTalk(_ sender: Any) {
        let controller = TalkViewController.instantiateStoryboard() as! TalkViewController
        controller.nickname = self.targetUser?.nickname ?? ""
        controller.toUserId = self.targetUser?.userId ?? 0
        controller.imageUrl = self.targetUser?.imageUrl ?? ""
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func imageTapped(){
        
        let _navigationController = PhotoViewerViewController.instantiateStoryboard()
        let controller = _navigationController as! PhotoViewerViewController
        controller.userImage = userImage
        _navigationController.modalPresentationStyle = .fullScreen
        navigationController?.present(_navigationController, animated: true, completion: nil)
    }
    
    func getPlistData() -> ProfileDataSource?
    {
        if  let path = Bundle.main.path(forResource: "ProfileList", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let plistData = try? PropertyListDecoder().decode(ProfileDataSource.self, from: xml)
        {
            return plistData
        }

        return nil
    }
    
    func getOptionArray(data: [String]!) -> [OptionData] {
        var listItem: [OptionData]! = [OptionData()]
        listItem.removeAll()
        for item in data {
            let data = item.components(separatedBy: "_")
//            print("itemData", data[0], data[1])
            let optionData = OptionData.init(id: Int(data[1]) ?? 0, title: data[0])
            listItem.append(optionData)
        }
        return listItem
    }
}

extension DetailFeedViewController: ProfileViewProtocol{
    func buildView(data: ProfileModel) {
        endProcess()
        NSLog("build view")
        self.targetUser = data
        if data.imageSize != nil {
            self.setImageBanner(data: data)
            self.imageUrl = data.imageUrl!
        }

        self.aboutMeTextView.text = data.aboutMe
        self.nicknameLabel.text = data.nickname

        if data.age != 0 {
            self.ageContent.isHidden = false
            if let stringAge = data.age.map(String.init) {
                self.ageLabel.text = stringAge
            }
        }

        let genderTitle = self.getOptionArray(data: self.getPlistData()!.genderArray)
        for item in genderTitle {
            if data.gender == item.id {
                self.sexLabel.text = item.title
            }
        }

        let occupancyTitle = self.getOptionArray(data: self.getPlistData()!.occupationArray)
        for item in occupancyTitle {
            if data.job == item.id {
                self.occupancyLabel.text = item.title
            }
        }

        if data.residence != nil && data.residence != "" {
            self.areaContent.isHidden = false
            self.areaLabel.text = data.residence
        }

        if data.hobby != nil && data.hobby != "" {
            self.hobbyContent.isHidden = false
            self.hobbyLabel.text = data.hobby
        }

        let characterTitle = self.getOptionArray(data: self.getPlistData()!.characterArray)
        for item in characterTitle {
            if data.personality == item.id {
                self.characterLabel.text = item.title
            }
        }
    }
    
    func setImageBanner(data: ProfileModel) {
        let width = UIScreen.main.bounds.width

        let separateSize = data.imageSize?.components(separatedBy: "x")
        let _width = CGFloat(Int(separateSize![0]) ?? 0)
        let height = CGFloat(Int(separateSize![1]) ?? 0)

        var newHeight: CGFloat?

        if _width > height {
            let widthRatio = _width / height
            newHeight = width / widthRatio
        } else {
            let heightRatio = height / _width
            newHeight = width * heightRatio
        }

        for constraint in profileImageView.constraints {
            if constraint.identifier == "profileImage" {
                constraint.constant = newHeight ?? 0
            }
        }
        profileImageView.layoutIfNeeded()
    }
    
    func buildError(_ error: ErrorPerResponse?) {
        endProcess()
        NSLog("build error")
        showAPIError(error)
    }
    
    func editProfileResponse(response: EmptyResponse) {
    
    }
    
    func deleteAccountResponse() {
     
    }
    
    
}
