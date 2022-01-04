//
//  MediaManagerViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 03/01/22.
//

import UIKit
import Photos
import CHTCollectionViewWaterfallLayout


class MediaManageViewController: UIViewController {
    static var PROFILE = "Profile"
    static var TALK = "Talk"
    static var IMAGE = "image"
    static var VIDEO = "video"
    var imageArray = [UIImage]()
    var mediaType = [String]()
    var videoArray = [Data?]()
    var selectedImage = 0
    var source = PROFILE
    var mode = IMAGE
    var presenter: MediaPresenterProtocol!
    var delegate: MediaManageProtocol?

    @IBOutlet var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.dataSource = self
            imageCollectionView.delegate = self
            self.setupCollectionView()
            imageCollectionView.register(cellType: ImageCollectionViewCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Media"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closePage))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black

        presenter = MediaPresenter(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoading()
        grabPhotos()
    }
    
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()

        layout.minimumColumnSpacing = 5.0
        layout.columnCount = 3
        layout.minimumInteritemSpacing = 5.0
        

        imageCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageCollectionView.alwaysBounceVertical = true

        imageCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        imageCollectionView.collectionViewLayout = layout
    }

    @objc func closePage() {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageCollectionView.collectionViewLayout.invalidateLayout()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func dismissLoading() {
        dismiss(animated: false, completion: nil)
    }
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: false, completion: nil)
    }
    
    func grabPhotos() {
        imageArray = []
        mediaType = []
        videoArray = []

        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager = PHImageManager.default()

            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.isNetworkAccessAllowed = true

            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            var fetchResult: PHFetchResult<PHAsset>
            if self.source == MediaManageViewController.TALK{
                fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
                fetchResult = PHAsset.fetchAssets(with: fetchOptions)
            }else{
                fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            }
            
            if fetchResult.count > 0 {
                for i in 0 ..< fetchResult.count {
                    if fetchResult[i].mediaType == .image {
                        self.mediaType.append("\(MediaManageViewController.IMAGE)_\(i)")
                        self.videoArray.append(nil)
                    }else{
                        self.mediaType.append("\(MediaManageViewController.VIDEO)_\(i)")
                        //add the video to array
                        let options: PHVideoRequestOptions = PHVideoRequestOptions()
                        options.version = .current
                        PHImageManager.default().requestAVAsset(forVideo: fetchResult.object(at: i) as PHAsset, options: options, resultHandler: {(asset, audioMix, info) in
                            if let urlAsset = asset as? AVURLAsset {
                                let localVideoUrl = urlAsset.url
                                let data = try! Data(contentsOf: localVideoUrl, options: .mappedIfSafe)
                                
                                self.videoArray.append(data)
                            }
                        })
                    }
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, info) in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("You have no photos.")
            }
            print("mediaArray count: \(self.imageArray.count)")

            DispatchQueue.main.async {
                self.dismissLoading()
                print("This is run on the main queue, after the previous code in outer block")
                self.imageCollectionView.reloadData()
            }
        }

        if #available(iOS 13.0, *) {
            self.mediaType.append(MediaManageViewController.IMAGE)
            self.imageArray.append(UIImage(named: "icon_camera")!)
        } else {
            mediaType.append(MediaManageViewController.IMAGE)
            imageArray.append(UIImage(imageLiteralResourceName: "icon_camera"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MediaManageViewController: UICollectionViewDelegate,UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.buildView(data: imageArray[indexPath.item], index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width / 3 - 5, height: width / 3 - 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            if indexPath.row > 0 {
                cell.showIcon()
                let mType = mediaType[indexPath.item].split(separator: "_")
                mode = String(mType[0])
                if source == MediaManageViewController.PROFILE {
                    selectedImage = indexPath.item
                }else{
                    if mode == MediaManageViewController.IMAGE {
                        selectedImage = indexPath.item
                    }else{
                        selectedImage = Int(mType[1]) ?? -1
                    }
                    print("mode \(mode)")
                    print("index \(Int(mType[1]) ?? -1)")
                    print("selected \(selectedImage)")
                }
                
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(pickImage))
                navigationItem.rightBarButtonItem?.tintColor = UIColor.ex.blue
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
                openCamera()
            }
        }
    }

    @objc func pickImage() {
        if mode == MediaManageViewController.IMAGE{
            uploadImage(image: imageArray[selectedImage])
        }else{
            showLoading()
            presenter.uploadVideo(video: videoArray[selectedImage]!)
        }
    }

    func uploadImage(image: UIImage) {
        showLoading()
        presenter.uploadImage(location: self.source, image: image)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            cell.hideIcon()
        }
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            do {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                present(picker, animated: false)
            } catch {
                print("error")
            }

        } else {
            showErrorBox(msg: "no available camera")
        }
    }
}

extension MediaManageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: false, completion: {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage?

            if image != nil {
                self.uploadImage(image: image!)
            }
        })
    }
}

extension MediaManageViewController: MediaProtocol {
    
    func showSuccess(imageId: Int) {
        dismiss(animated: false, completion: {
//            if let rootVc = self.navigationController?.viewControllers.first as? MyPageViewController {
//                rootVc.image.image = self.imageArray[self.selectedImage]
//            }

            if self.source == MediaManageViewController.TALK {
                if self.mode == MediaManageViewController.IMAGE {
                    self.delegate?.pictureSelected(imageId: imageId)
                }else{
                    self.delegate?.videoSelected(videoId: imageId)
                }
            }
            self.dismiss(animated: true, completion: nil)
        })
    }

    func showError(_ error: ErrorPerResponse) {
        showAPIError(error)
    }
}

protocol MediaManageProtocol {
    func pictureSelected(imageId: Int)
    
    func videoSelected(videoId: Int)
}

