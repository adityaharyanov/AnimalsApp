//
//  FullPreviewImageViewController.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import UIKit
import Kingfisher

class FullImageViewController: UIViewController {
    
    private var url: String = ""
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    convenience init(url: String) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        view.addSubview(imageView)
        
        imageView.anchorFill(to: view.layoutMarginsGuide)
        imageView.kf.setImage(with: URL(string: url ))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
