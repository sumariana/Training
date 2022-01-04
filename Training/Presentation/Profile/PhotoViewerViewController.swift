//
//  PhotoViewerViewController.swift
//  Training
//
//  Created by TimedoorMSI on 10/12/21.
//

import UIKit

class PhotoViewerViewController: UIViewController, UIScrollViewDelegate {
    var userImage: UIImage? = nil
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var imageView: UIImageView!{
        didSet{
            imageView.image = userImage
        }
    }
    @IBOutlet var scrollView: UIScrollView!

    var imageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupimage()
    }
    
    func setupimage() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGest)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
      }

    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
