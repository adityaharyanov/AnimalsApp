//
//  AnimalListViewController.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class AnimalListViewController: UIViewController {
    var viewModel: AnimalListViewModel!
    
    
    // MARK: View Components
    lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.placeholder = "Search"
        searchbar.showsCancelButton = true
        return searchbar
    }()
    
    lazy var tableView: UITableView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .systemBackground
        tableView.delegate = nil
        return tableView
    }()
    
    lazy var seeFavouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See Favourited Image", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.systemPink
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(goFavouriteList), for: .touchUpInside)
        return button
    }()
    
    lazy var container: UIStackView = { [weak self] in
        guard let self = self else { return UIStackView(arrangedSubviews: []) }
        
        var container = UIStackView(arrangedSubviews: [self.searchBar, self.tableView, self.seeFavouriteButton])
        container.isHidden = true
        container.axis = .vertical
        container.alignment = .fill
        container.distribution = .fill
        
        return container
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        
        return loading
    }()
    
    //MARK: Life Cycles
    convenience init(viewModel: AnimalListViewModel) {
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: Methods
    private func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(container)
        
        container.anchorFill(to: view.safeAreaLayoutGuide)
        seeFavouriteButton.anchorSize(height: 44)
        seeFavouriteButton.anchorBottom(padding: 30)
        seeFavouriteButton.anchorLeading(padding: 12)
        seeFavouriteButton.anchorTrailing(padding: 12)
    }
    
    func setupBinding() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.animals.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { (_, item, cell) in
            cell.textLabel?.text = item.name
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isLoading in
                self?.container.isHidden = isLoading
            }
        
        tableView.rx.modelSelected(Animal.self)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] value in
            self?.goImageList(value.name)
        }).disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected row: \(indexPath.row)")
        }).disposed(by: viewModel.disposeBag)
    }
    
    private func goImageList(_ data: String) {
        let imageListVC = ImageListViewController(viewModel: ImageListViewModel(data: data, repository: ImageRepositoryImpl()))
        navigationController?.pushViewController(imageListVC, animated: true)
    }
    
    @objc private func goFavouriteList() {
        let imageListVC = ImageListViewController(viewModel: ImageListViewModel(repository: ImageRepositoryImpl()))
        navigationController?.pushViewController(imageListVC, animated: true)
    }
}
