//
//  RepoListCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import UIKit
import RxRelay
import RxSwift

protocol RepoListListener {
    func didFinishSelectLanguage(language: String)
}

class RepoListCoordinator: BaseCoordinator {
    
    deinit {
        print("deinit")
    }
    
    private let disposeBag = DisposeBag()
    private var repoListViewModel: RepositoryListViewModelType!
    private var repoListViewController: RepoListViewController!
    
    override func start() {
        
        repoListViewModel = RepositoryListViewModel(initialLanguage: "Swift")
        repoListViewController = RepoListViewController(viewModel: repoListViewModel)
        
        repoListViewModel.showLanguageList.subscribe(onNext: { [weak self] in
            
            self?.showLanguageList()
            
        }).disposed(by: disposeBag)
        
        repoListViewModel.didDismiss.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            self.parentCoordinator?.didFinish(coordinator: self)
        }).disposed(by: disposeBag)
        
        navigationController.pushViewController(repoListViewController, animated: true)
    }
    
    func backToHome() {
        // Do nothing
    }
    
    func showLanguageList() {
        let languageListCoordinator = LanguageListCoordinator(navigationController: navigationController)
        start(coordinator: languageListCoordinator)
    }
}

extension RepoListCoordinator: RepoListListener {
    func didFinishSelectLanguage(language: String) {
        repoListViewModel.setCurrentLanguage.onNext(language)
    }
}
