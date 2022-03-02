//
//  LanguageListCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import UIKit
import RxSwift

class LanguageListCoordinator: BaseCoordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        
        let viewModel = LanguageListViewModel(githubService: GithubService())
        
        let languageListVC = LanguageListViewController(viewModel: viewModel)
        
        viewModel.didSelectLanguage.subscribe(onNext: {
            [weak self] language in
            
            guard let `self` = self else { return }
            languageListVC.dismiss(animated: true, completion: nil)
            (self.parentCoordinator as? RepoListListener)?.didFinishSelectLanguage(language: language)
            self.parentCoordinator?.didFinish(coordinator: self)
            
        }).disposed(by: disposeBag)
        
        viewModel.didCancel.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            languageListVC.dismiss(animated: true, completion: nil)
            self.parentCoordinator?.didFinish(coordinator: self)
        }).disposed(by: disposeBag)
        let nav = UINavigationController(rootViewController: languageListVC)
        navigationController.present(nav, animated: true, completion: nil)
    }
    
}
