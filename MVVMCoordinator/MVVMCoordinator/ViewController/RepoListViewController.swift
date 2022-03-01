//
//  RepoListViewController.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
import SafariServices

class RepoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: RepositoryListViewModelType!
    
    private let refreshControl = UIRefreshControl()
    private let chooseLanguageButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: String(describing: RepoListViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = RepositoryListViewModel(initialLanguage: "Swift")
        
        // Binding
        setupBinding()
        // Setup table view
        setupUI()
        
        refreshControl.sendActions(for: .valueChanged)
        
        
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = chooseLanguageButton
        let nib = UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    private func setupBinding() {
        viewModel.repositories
            .observe(on: MainScheduler.instance)
            .do(onNext:
                    { [weak self] _ in self?.refreshControl.endRefreshing() })
                .bind(to: tableView
                        .rx
                        .items(cellIdentifier: String(describing: RepositoryTableViewCell.self),
                               cellType: RepositoryTableViewCell.self)) {
                    (_, repo, cell) in
                    cell.setupCell(repository: repo)
            }
            .disposed(by: disposeBag)

        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.alertMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)

        // View Controller UI actions to the View Model

        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
//        chooseLanguageButton.rx.tap
//            .bind(to: viewModel.chooseLanguage)
//            .disposed(by: disposeBag)
        
        chooseLanguageButton.rx.tap.subscribe(onNext: { [weak self] in
            
            guard let `self` = self else { return }
            
            let languageListViewController = LanguageListViewController()
            
            let navigationController = UINavigationController(rootViewController: languageListViewController)
            
            languageListViewController
                .viewModel
                .didSelectLanguage
                .subscribe(onNext: {[weak self] language in
                    
                    print("Did select language: \(language)")
                    self?.viewModel.setCurrentLanguage.onNext(language)
                    languageListViewController.dismiss(animated: true, completion: nil)
                    // self?.viewModel.reload.onNext(())
                    
                }).disposed(by: self.disposeBag)
            
            self.present(navigationController, animated: true, completion: nil)
        }).disposed(by: disposeBag)

//        tableView.rx.modelSelected(RepositoryViewModel.self)
//            .bind(to: viewModel.selectRepository)
//            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(RepositoryViewModel.self).subscribe(onNext: { [weak self] repoViewModel in
            guard let `self` = self else { return }
            self.showRepository(by: repoViewModel.url, in: self.navigationController ?? UINavigationController())
        }).disposed(by: disposeBag)
    }
    
    private func showRepository(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
}
