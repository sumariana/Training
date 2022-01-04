//
//  FeedViewController.swift
//  Training
//
//  Created by I Gusti Made Sumariana on 26/10/21.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class FeedViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet var feedCollectionView: UICollectionView!

    var feedData: FeedResponse?
    var presenter: FeedPresenter!
    var isSwipeRefresh = false
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TrainingApp"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        feedCollectionView.addSubview(refreshControl)

        presenter = FeedPresenter(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onProcess()
        presenter.getFeed(lastLoginTime: nil)
    }

    @objc func refresh(_ sender: AnyObject) {
        isSwipeRefresh = true
        presenter.getFeed(lastLoginTime: nil)
    }
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()

        layout.minimumColumnSpacing = 10.0
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 10.0

        feedCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        feedCollectionView.alwaysBounceVertical = true

        feedCollectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        feedCollectionView.collectionViewLayout = layout
    }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 1
        return CGSize(width: width, height: 250)
//        if feedData?.items[indexPath.row].imageSize != nil {
//            let separateSize = feedData?.items[indexPath.row].imageSize?.components(separatedBy: "x")
//            let _width = CGFloat(Int(separateSize![0]) ?? 0)
//            let height = CGFloat(Int(separateSize![1]) ?? 0)
//            var size = CGSize()
//
//            if _width > height {
//                let widthRatio = _width / height
//                size = CGSize(width: width * widthRatio - 1, height: width + 274)
//            } else {
//                let heightRatio = height / _width
//                size = CGSize(width: width, height: width * heightRatio + 180)
//            }
//            return size
//        } else {
//            return CGSize(width: width, height: width + 180)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if feedData?.items != nil {
            cell.buildView(data: feedData!.items[indexPath.row])
        }
        cell.contentView.layoutIfNeeded()
        cell.layoutIfNeeded()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isLoading = true
        presenter.getFeed(lastLoginTime: feedData?.lastLoginTime)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FeedCollectionViewCell
        
        let _navigationController = DetailFeedViewController.instantiateStoryboard() as! UINavigationController
        
        let controller = _navigationController.viewControllers.first as! DetailFeedViewController
        
        controller.userId = feedData?.items[indexPath.row].userId ?? 0
        controller.userImage = cell.imageView.image
        _navigationController.modalPresentationStyle = .fullScreen
        navigationController?.present(_navigationController,animated: true,completion: nil)
    }
}

extension FeedViewController: FeedViewProtocol{
    func getFeedResponse(response: FeedResponse) {
        endProcess()
        if !isSwipeRefresh {
            if !isLoading {
                dismiss(animated: true, completion: {
                    self.feedData = response

                    self.feedCollectionView.dataSource = self
                    self.feedCollectionView.delegate = self
                    self.setupCollectionView()
                    self.feedCollectionView.register(cellType: FeedCollectionViewCell.self)
                })
            } else {
                self.isLoading = false
                self.feedData?.lastLoginTime = response.lastLoginTime
                self.feedData?.items.append(contentsOf: response.items)

               
                DispatchQueue.main.async {
                    self.feedCollectionView.reloadData()
                }
                self.feedCollectionView.layoutIfNeeded()
            }

        } else {
            
            self.feedData = response

            self.feedCollectionView.dataSource = self
            self.feedCollectionView.delegate = self
            self.setupCollectionView()
            self.feedCollectionView.register(cellType: FeedCollectionViewCell.self)
            self.refreshControl.endRefreshing()
        }
    }
    
    func errorResponse(_ error: ErrorPerResponse?) {
        endProcess()
        if !isSwipeRefresh {
            showAPIError(error)
        } else {
            showAPIError(error)
            refreshControl.endRefreshing()
        }
    }
}
