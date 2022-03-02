//
//  HomeCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = sb.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as! HomeViewController
        navigationController.viewControllers = [homeVC]
    }
    
    func gotoGithubRepo() {
        let repoListCoordinator = RepoListCoordinator(navigationController: navigationController)
        start(coordinator: repoListCoordinator)
    }
}
