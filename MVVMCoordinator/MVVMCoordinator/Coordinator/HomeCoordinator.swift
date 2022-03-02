//
//  HomeCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import RxSwift
import UIKit

class HomeCoordinator: BaseCoordinator {
    
    deinit {
        print("Deinit")
    }
    
    let disposeBag = DisposeBag()
    
    override func start() {
        
        let homeViewModel = HomeViewModel()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = sb.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as! HomeViewController
        homeVC.viewModel = homeViewModel
        
        homeViewModel.didGotoGithubRepoList.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else {
                return
            }
            self.gotoGithubRepo()
        }).disposed(by: disposeBag)
        
        navigationController.viewControllers = [homeVC]
    }
    
    func gotoGithubRepo() {
        let repoListCoordinator = RepoListCoordinator(navigationController: navigationController)
        start(coordinator: repoListCoordinator)
    }
}
