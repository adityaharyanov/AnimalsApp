//
//  ImageListViewController.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 19/07/24.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

final class ImageListViewController: UIViewController {
    
    var viewModel: ImageListViewModel!
    
    // MARK: View Components
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.isHidden = true
        return collectionView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        
        return loading
    }()
    
    lazy var emptyTextView: UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.text = "No Data Found"
        textview.textColor = UIColor.white
        textview.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textview.isHidden = true
        
        return textview
    }()
    
    //MARK: Life Cycles
    convenience init(viewModel: ImageListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupView()
        setupBinding()
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(emptyTextView)
        emptyTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.anchorFill(to: view.safeAreaLayoutGuide)
    }
    
    func setupBinding() {
        
        // CollectionView Binding
        viewModel.images
            .bind(to: collectionView.rx.items(cellIdentifier: ImageViewCell.identifier)) { index, item, cell in
                guard let cell = cell as? ImageViewCell else { return }
                
                if let imageUrl = item.src["medium"] {
                    cell.imageView.kf.setImage(with: URL(string: imageUrl))
                } else {
                    cell.imageView.image = UIImage(systemName: "pause.fill")
                }
                
                cell.setFavourite(to: item.isFavourited!)
                
                cell.didImageTapped = { [weak self] in
                    if let fullImageUrl = item.src["large"] {
                        self?.openFullImage(url: fullImageUrl)
                    }
                }
                
                cell.didFavouriteTapped = { [weak self] in
                    guard let result = self?.viewModel.toggleFavourite(at: index) else { return }
                    cell.setFavourite(to: result)
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: viewModel.disposeBag)
        
        // SCroll Reach Bottom Event Binding for Infinity Scroll
        collectionView.rx
            .onReachBottom(withOffset: 20.0)
            .map { [weak self] _ in
                return self?.viewModel.fetchNextPageImages()
            }
            .subscribe(onNext: { value in
                                
            }).disposed(by: viewModel.disposeBag)
        
        // Loading & Content Interchangeable Binding
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .map({ [weak self] isLoading in
                return (isLoading, (self?.viewModel.images.value.isEmpty ?? true) )
            })
            .subscribe { [weak self] (isLoading, isEmpty) in
                self?.loadingView.isHidden = !isLoading
                
                self?.collectionView.isHidden = isEmpty
                self?.emptyTextView.isHidden = !isEmpty
            }
        
    }
    
    private func openFullImage(url: String) {
        let vc = FullImageViewController(url: url)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

//MARK: UICollectionViewDelegateFlowLayout

let CARD_WIDTH_RATIO = 245.0
let CARD_HEIGHT_RATIO = 342.0

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.frame.width / 2 - 10.0 - (layout.minimumInteritemSpacing / 2)
        let height = (342.0 / CARD_WIDTH_RATIO) * width
        
        return CGSize(width: width, height: height)
    }
}

