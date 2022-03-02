//
//  AppCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation
import UIKit
import RxSwift

protocol SignInListener {
    func didSignIn()
}

class AppCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
        
    override func start() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
        
        // add child coordinator
        let signInCoordinator = SignInCoordinator(navigationController: navigationController)
        start(coordinator: signInCoordinator)
    }
}

extension AppCoordinator: SignInListener {
    func didSignIn() {
        // Go to Dashboard
        // Init home view controller
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}

