//
//  TalkViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 15/12/21.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Photos

class TalkViewController: UIViewController {
    var nickname: String = ""
    var toUserId: Int = 0
    var imageUrl: String = ""
    var presenter: TalkPresenter!
    var window: UIWindow?
    
    @IBOutlet var ivMedia: UIImageView!
    var talksData: [(String,Array<TalkItems>)] = []
    var imagePicker : ImagePicker!
    
    @IBOutlet var talkTB: UITableView!
    @IBOutlet var etInput: UITextView!{
        didSet{
            etInput.layer.borderColor = UIColor.ex.darkGray.cgColor
            etInput.layer.borderWidth = 0.5
            etInput.layer.cornerRadius = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = nickname
        presenter = TalkPresenter(self)
        talkTB.transform = CGAffineTransform(scaleX: 1, y: -1)
        self.talkTB.dataSource = self
        self.talkTB.delegate = self
        onProcess()
        presenter.loadTalkList(toUserId: toUserId, borderMessage: 0, howToRequest: 0)
        registerCell()
        
        let media = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        ivMedia.isUserInteractionEnabled = true
        ivMedia.addGestureRecognizer(media)
    }
    
    func openGallery() {
        
        let _nav = MediaManageViewController.instantiateStoryboard() as! UINavigationController
        let controller = _nav.viewControllers.first as! MediaManageViewController
        controller.source = MediaManageViewController.TALK
        controller.delegate = self
        _nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(_nav, animated: true, completion: nil)
    }
    
    @objc func cameraTapped() {
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
    
    @IBAction func sendMessage(_ sender: Any) {
        if etInput.text.isEmpty {return}
        
        presenter.sendMessage(toUserId: toUserId, message: etInput.text)
        onProcess()
        
    }
    
    func registerCell(){
        talkTB.register(UINib(nibName: "TalkOutViewCell", bundle: nil), forCellReuseIdentifier: "TalkOutViewCell")
        talkTB.register(UINib(nibName: "TalkInViewCell", bundle: nil), forCellReuseIdentifier: "TalkInViewCell")
    }
    
    private func groupByDate(talkItem: [TalkItems]) -> [(String,Array<TalkItems>)]? {
        //Group talk item by data
        if talkItem.count < 1 { return nil }
        
        var itemsGroupedByDate: [(String,Array<TalkItems>)] = []
        var items: [TalkItems] = []
        var lastDate: String!
        
        for item in talkItem {
            let date = item.time
            if lastDate == nil { lastDate = date }
            
            let denormalizeLastDate = dateFormatFromDateString(date: lastDate, format: "dd/MM/yy")
            let denormalizeDate = dateFormatFromDateString(date: date ?? "", format: "dd/MM/yy")
            
            if denormalizeLastDate != denormalizeDate {
                itemsGroupedByDate.append((lastDate, items))
                items = []
                lastDate = date
            }
            items.append(item)
        }
        
        //Add last item
        itemsGroupedByDate.append((lastDate, items))
        
        return itemsGroupedByDate
    }
    func createLabelForHeader(date: String) -> UILabel{
        let label = UILabel()
        label.text = UTCToLocal(date: date, format: "dd/MM")
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        label.backgroundColor = UIColor.ex.gray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = UIColor.ex.black
        
        return label
    }
}

extension TalkViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talksData[section].1.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return talksData.count
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
         return talksData[section].0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //Add custom label for header section
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let lblWidth = CGFloat(80)
        let sectionWidth = footer.frame.width
        
        let label = createLabelForHeader(date: talksData[section].0)
        label.frame = CGRect.init(x: (sectionWidth / 2) - (lblWidth / 2), y: 5, width: lblWidth, height: 25)
        
        footer.addSubview(label)
        footer.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = talksData[indexPath.section].1
        //Decide which cell to show based on message kind
        //Message kind: 1=In, 2=Out
        let identifier =  item[indexPath.row].messageKind == 1 ? "TalkInViewCell" : "TalkOutViewCell"
        let chatCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TalkTableViewCell
        
        chatCell.profileImage = imageUrl
        chatCell.item = item[indexPath.row]
        //chatCell.delegate = self
        
        chatCell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return chatCell
    }

}

extension TalkViewController: TalkViewProtocol, MediaManageProtocol{
    func pictureSelected(imageId: Int) {
        self.presenter.sendImage(toUserid: self.toUserId, imageId: imageId)
    }
    
    func videoSelected(videoId: Int) {
        self.presenter.sendVideo(toUserId: self.toUserId, videoId: videoId)
    }
    
    func successSendMessage() {
        endProcess()
        self.etInput.text = ""
        presenter.loadTalkList(toUserId: toUserId, borderMessage: 0, howToRequest: 0)
    }
    
    func buildView(talkList: [TalkItems]) {
        endProcess()
        
        guard let items = groupByDate(talkItem: talkList) else {
            return
        }
        talksData = items
        self.talkTB.reloadData()
    }
    
    func errorResponse(_ error: ErrorPerResponse?) {
        endProcess()
    }
}
