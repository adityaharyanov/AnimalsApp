//
//  ImageViewCell.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    
    static let identifier = "ImageViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var favouriteButton: UIImageView = {
        let button = UIImageView()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "heart")
        button.contentMode = .scaleAspectFill
        button.tintColor = UIColor.red
        
        return button
    }()
    
    var didImageTapped: (() -> Void)? {
        didSet {
            if let _ = didImageTapped {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(completion))
                imageView.gestureRecognizers = []
                imageView.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    var didFavouriteTapped: (() -> Void)? {
        didSet {
            if let _ = didFavouriteTapped {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didFavouriteHandler))
                favouriteButton.gestureRecognizers = []
                favouriteButton.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(favouriteButton)
        favouriteButton.anchorSize(width: 30, height: 30)
        favouriteButton.anchorBottom(padding: 5)
        favouriteButton.anchorTrailing(padding: 5)
    }
    
    func setFavourite(to isFavourite:Bool) {
        if isFavourite {
            favouriteButton.image = UIImage(systemName: "heart.fill")
        } else {
            favouriteButton.image = UIImage(systemName: "heart")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func completion() {
        didImageTapped?()
    }
    
    @objc private func didFavouriteHandler() {
        didFavouriteTapped?()
    }
}
