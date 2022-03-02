//
//  HomeViewModel.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 02/03/2022.
//

import Foundation
import RxSwift

protocol HomeViewModelType {
    var didGotoGithubRepoList: Observable<Void> { get set }
    var gotoGithub: AnyObserver<Void> { get set }
}

class HomeViewModel: HomeViewModelType {
    
    var didGotoGithubRepoList: Observable<Void>
    
    var gotoGithub: AnyObserver<Void>
    
    init() {
        let _gotoGithub = PublishSubject<Void>()
        self.gotoGithub = _gotoGithub.asObserver()
        self.didGotoGithubRepoList = _gotoGithub.asObservable()
    }
}
