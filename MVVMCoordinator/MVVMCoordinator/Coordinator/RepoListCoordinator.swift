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
    
    private let disposeBag = DisposeBag()
    private var repoListViewModel: RepositoryListViewModelType!
    override func start() {
        repoListViewModel = RepositoryListViewModel(initialLanguage: "Swift")
        let repoListViewController = RepoListViewController(viewModel: repoListViewModel)
        
        repoListViewModel.showLanguageList.subscribe(onNext: { [weak self] in
            self?.showLanguageList()
        }).disposed(by: disposeBag)
        
        let navController = self.parentCoordinator?.navigationController
        navController?.pushViewController(repoListViewController, animated: true)
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
