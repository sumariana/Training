//
//  MyPageViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 26/10/21.
//

import UIKit
import Photos

class MyPageViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var username: MenuLabel!
    @IBOutlet var password: MenuLabel!
    @IBOutlet var tnc: MenuButton!
    @IBOutlet var deleteAccount: MenuButton!
    
    
    var presenter: ProfilePresenterProtocol!
    var userData: ProfileModel?
    var isPhotoNull: Bool = true
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRounded()
        self.presenter = ProfilePresenter(self)
        //self.navigationController?.navigationBar.isHidden = true
        
        let logoutBarButtonItem = UIBarButtonItem(title: "logout".localized, style: .done, target: self, action: #selector(doLogout))
        logoutBarButtonItem.tintColor = ColorCode.black
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(cameraTap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onProcess()
        presenter.fetchProfile()
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UITitleLabel()
        titleLabel.setTitle(title: title)
        
        let subtitleLabel = UISubtitleLabel()
        subtitleLabel.setTitle(title: subtitle)

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        return titleView
    }
    
    @objc func doLogout(){
        User.shared.logout()
        let login = PisangViewController.instantiateStoryboard()
        login.modalTransitionStyle = .crossDissolve
        login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true)
    }
    
    @IBAction func openTNC(_ sender: Any) {
        let controller = WebViewController.instantiateStoryboard() as! WebViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.url = APIConstant.webviewUrl.rawValue
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func deleteAcountAction(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "delete_account".localized, message: "Are you sure want to delete account ?".localized, preferredStyle: UIAlertController.Style.alert)

        deleteAlert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { (action: UIAlertAction!) in
            self.deleteAcc()
        }))

        deleteAlert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: { (action: UIAlertAction!) in
            deleteAlert.dismiss(animated: true)
        }))

        present(deleteAlert, animated: true, completion: nil)
    }
    
    func deleteAcc(){
        onProcess()
        presenter.deleteAccount()
    }
    
    func openGallery() {
        
        let _nav = MediaManageViewController.instantiateStoryboard() as! UINavigationController
        let controller = _nav.viewControllers.first as! MediaManageViewController
        controller.source = MediaManageViewController.PROFILE
        _nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(_nav, animated: true, completion: nil)
    }
    
    func openImagePicker(){
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.openGallery()
                    }
                }else{
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.window?.rootViewController?.present(alert, animated: false, completion: nil)
                }
            })
        
        } else if photos == .authorized {
            self.openGallery()
        }
    }
    
    @objc func cameraTapped() {
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Select Image", style: .default , handler:{ (UIAlertAction) in
                self.openImagePicker()
                
            }))
        if !isPhotoNull {
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ [self] (UIAlertAction) in
                self.deleteImage()
            }))
        }
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: false, completion: {
                print("completion block")
            })
    }
    
    @IBAction func showEditOption(_ sender: Any) {
        let controller = ProfileViewController.instantiateStoryboard() as! ProfileViewController
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func makeRounded() {
        image.layer.borderWidth = 0.5
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.ex.black.cgColor
        self.image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
//    func updateImageProfile(_ image: UIImage){
//        self.image.image = image
//        mediaPresenter.uploadImage(location: "Profile", image: image)
//    }
    
    func deleteImage(){
        guard let imageId = userData?.imageId else {
            return
        }
        onProcess()
        var request = ProfileRequest()
        request.image_id = imageId
        self.presenter.editProfile(editProfileRequest: request)
    }

}

extension MyPageViewController: ProfileViewProtocol {
    
    func editProfileResponse(response: EmptyResponse) {
        
    }
    
    func deleteAccountResponse() {
        endProcess()
        doLogout()
    }
    
    func buildView(data: ProfileModel) {
        endProcess()
        makeRounded()
        if data.imageUrl != nil {
            self.isPhotoNull = false
        }
        self.image.loadProfileImage(data.imageUrl ?? "")
        self.navigationItem.titleView = setTitle(title: data.nickname , subtitle: String(data.userId ))
        self.username.text = data.nickname
        self.password.text = data.password
    }
    
    func buildError(_ error: ErrorPerResponse?) {
        endProcess()
        showAPIError(error)
    }
        
}
