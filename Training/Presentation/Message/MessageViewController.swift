//
//  MessageViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 26/10/21.
//

import CHTCollectionViewWaterfallLayout
import RealmSwift
import UIKit

class MessageViewController: UIViewController {

    let refreshControl = UIRefreshControl()
    var isSwipeRefresh = false
    var isLoading = false
    var isEditMode = false
    var selectedId: [String] = []
    @IBOutlet var messageCollectionView: UICollectionView!
    @IBOutlet var deleteBtn: UIButton!

    var presenter: MessagePresenter!
    var messageData: [MessageLocalItem]?

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "TrainingApp"

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        messageCollectionView.addSubview(refreshControl)

        let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editMode))
        navigationItem.rightBarButtonItem = editButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.ex.black

        presenter = MessagePresenter(self)

        realm.beginWrite()
        realm.delete(realm.objects(Person.self))
        try! realm.commitWrite()

        presenter.getlocalMessage()
    }

    @objc func editMode() {
        let title = navigationItem.rightBarButtonItem?.title
        if title == "edit" {
            navigationItem.rightBarButtonItem?.title = "cancel"
            validateDeleteBtn()
            isEditMode = true
            deleteBtn.isHidden = false
            messageCollectionView.reloadData()
        } else {
            navigationItem.rightBarButtonItem?.title = "edit"
            isEditMode = false
            deleteBtn.isHidden = true
            messageCollectionView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        presenter.fetchMessage(lastLoginTime: "")
    }

    @objc func refresh(_ sender: AnyObject) {
        if navigationItem.rightBarButtonItem?.title == "cancel" {
            editMode()
        }
        isSwipeRefresh = true
        presenter.fetchMessage(lastLoginTime: "")
    }

    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 1
        messageCollectionView.collectionViewLayout = layout
    }

    func validateDeleteBtn() {
        if selectedId.isEmpty {
            deleteBtn.backgroundColor = UIColor.ex.gray
            deleteBtn.isEnabled = false
        } else {
            deleteBtn.isEnabled = true
            deleteBtn.backgroundColor = UIColor.ex.orange
        }
    }

    @IBAction func deleteBtnListener(_ sender: Any) {
        onProcess()
        let talkId = selectedId.joined(separator: ",")

        presenter.deleteMessage(talkId: talkId)
    }
}

extension MessageViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageData?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MessageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.buildView(messageItem: messageData?[indexPath.row], addSelectedIdFunc: { id in
            self.addItemId(id: id)
        },
        removeSelectedIdFunc: { id in
            self.removeItemId(id: id)
        })
        cell.changeMode(isEditMode: isEditMode)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingFor section: Int) -> CGFloat {
        return -1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditMode {
            let controller = TalkViewController.instantiateStoryboard() as! TalkViewController
            let person = messageData?[indexPath.row]
            controller.nickname = person?.nickname ?? ""
            controller.toUserId = person?.toUserId ?? 0
            controller.imageUrl = person?.imageUrl ?? ""
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func removeItemId(id: Int) {
        selectedId.append(String(id))

        validateDeleteBtn()
    }

    func addItemId(id: Int) {
        selectedId = selectedId.filter {
            $0 != String(id)
        }

        validateDeleteBtn()
    }
}

extension MessageViewController: MessageViewProtocol {
    func deleteMessageSuccess() {
        editMode()
        isSwipeRefresh = true
        isLoading = true
        presenter.fetchMessage(lastLoginTime: "")
        messageCollectionView.reloadData()
    }

    func buildView(messageLocalItem: [MessageLocalItem]) {
        if !isSwipeRefresh {
            if !isLoading {
                self.messageData = messageLocalItem

                self.messageCollectionView.dataSource = self
                self.messageCollectionView.delegate = self
                self.setupCollectionView()
                self.messageCollectionView.register(cellType: MessageCollectionViewCell.self)
            } else {
                isLoading = false

                DispatchQueue.main.async {
                    self.messageCollectionView.reloadData()
                }
            }
        } else {
            if isLoading {
                self.isLoading = false
                self.messageData = messageLocalItem

                self.messageCollectionView.dataSource = self
                self.messageCollectionView.delegate = self
                self.setupCollectionView()
                self.messageCollectionView.register(cellType: MessageCollectionViewCell.self)
                
                self.messageCollectionView.reloadData()
            } else {
                messageData = messageLocalItem

                messageCollectionView.dataSource = self
                messageCollectionView.delegate = self
                setupCollectionView()
                messageCollectionView.register(cellType: MessageCollectionViewCell.self)
                refreshControl.endRefreshing()
                self.messageCollectionView.reloadData()
            }
        }
    }

    func errorResponse(_ error: ErrorPerResponse?) {
        if !isSwipeRefresh {
            showAPIError(error)
        } else {
            showAPIError(error)
            refreshControl.endRefreshing()
        }
    }
}

class Person: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var age: Int = 0
}
