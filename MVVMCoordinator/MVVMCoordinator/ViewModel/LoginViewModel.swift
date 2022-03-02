//
//  LoginViewModel.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol LoginViewModelType {
    
    var isSigninEnable: Observable<Bool> { get set }
    var emailString: BehaviorRelay<String> { get set }
    var passwordString: BehaviorRelay<String> { get set }
    
    var signInSuccess: PublishRelay<Void> { get set }
    var signInFailure: PublishRelay<Error> { get set }
    
    func signInTapped()
}

class LoginViewModel: LoginViewModelType {
    
    var emailString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var passwordString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var isSigninEnable: Observable<Bool>
    var signInFailure: PublishRelay<Error> = PublishRelay()
    var signInSuccess: PublishRelay<Void> = PublishRelay()
    
    private var authenService: AuthentiationServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(authenService: AuthentiationServiceProtocol) {
        isSigninEnable = Observable.combineLatest(emailString, passwordString).map({ $0.0 != "" && $0.1 != ""})
        self.authenService = authenService
    }
    
    func signInTapped() {
        let _ = emailString.value
        let _ = passwordString.value
        
        // then sign in
        authenService.signIn().subscribe {[weak self] singInResponse in
            // Success
            self?.signInSuccess.accept(())
            
        } onFailure: { [weak self] error in
            
            self?.signInFailure.accept(error)
        } onDisposed: {
            
        }.disposed(by: disposeBag)
        
    }
}
