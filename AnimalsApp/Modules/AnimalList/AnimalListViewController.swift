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
        
        let container = UIStackView(arrangedSubviews: [searchBar, tableView])
        container.axis = .vertical
        container.alignment = .fill
        container.distribution = .fill
        
        view.addSubview(container)
        
        container.anchorFill(to: view.safeAreaLayoutGuide)
    }
    
    func setupBinding() {
//        searchBar.rx.text
//            .orEmpty
//            .bind(to: viewModel.searchText)
//            .disposed(by: viewModel.disposeBag)
        
        viewModel.animals.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { (_, item, cell) in
            cell.textLabel?.text = item.name
        }.disposed(by: viewModel.disposeBag)
        
        tableView.rx.modelSelected(String.self)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] value in
            self?.goImageList(value)
        }).disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected row: \(indexPath.row)")
        }).disposed(by: viewModel.disposeBag)
    }
    
    private func goImageList(_ data: String) {
//        let cardDetailVC = CardDetailViewController(viewModel: CardDetailViewModel(data))
//        navigationController?.pushViewController(cardDetailVC, animated: true)
    }
}
