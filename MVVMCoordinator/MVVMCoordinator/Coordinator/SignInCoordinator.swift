//
//  SignInCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

// show sign in view
class SignInCoordinator: BaseCoordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let signViewController = sb.instantiateInitialViewController() as! LoginViewController
        let signInViewModel = LoginViewModel(authenService: SessionServic())
        signViewController.viewModel = signInViewModel
        signInViewModel.signInSuccess.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.navigationController.viewControllers = []
            self.parentCoordinator?.didFinish(coordinator: self)
            (self.parentCoordinator as? SignInListener)?.didSignIn()
        }).disposed(by: disposeBag)
        
        navigationController.viewControllers = [signViewController]
    }
}
