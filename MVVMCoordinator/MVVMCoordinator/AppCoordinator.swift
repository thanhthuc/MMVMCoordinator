//
//  AppCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation
import UIKit
import RxSwift

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
    func showSignIn()
    func showSetting()
}

class AppCoordinator: CoordinatorProtocol {
    
    private let disposeBag = DisposeBag()
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
        showSignIn()
    }
    
    func showSignIn() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = sb.instantiateInitialViewController() as? LoginViewController
        let authenServer = SessionServic()
        let viewModel = LoginViewModel(authenService: authenServer)
        loginViewController?.viewModel = viewModel
        
        viewModel.signInSuccess.subscribe { [weak self] void in
            
            let homeVC = sb.instantiateViewController(withIdentifier: String(describing: HomeViewController.self))
            self?.navigationController.pushViewController(homeVC, animated: true)
            
        }.disposed(by: disposeBag)

        viewModel.signInFailure.subscribe { error in
            // show error
        }.disposed(by: disposeBag)
        
        navigationController.viewControllers = [loginViewController!]
    }
    
    func showSetting() {
        
    }
    
    // Pros and cons
}

