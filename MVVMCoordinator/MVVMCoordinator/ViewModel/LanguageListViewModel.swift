//
//  LanguageListViewModel.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import RxSwift

protocol LanguageListViewModelType {
    var selectLanguage: AnyObserver<String> { get set }
    var cancel: AnyObserver<Void> { get set }
    // MARK: - Outputs
    var languages: Observable<[String]> { get set }
    var didSelectLanguage: Observable<String> { get set }
    var didCancel: Observable<Void> { get set }
}

class LanguageListViewModel: LanguageListViewModelType {
    
    var selectLanguage: AnyObserver<String>
    
    var cancel: AnyObserver<Void>
    
    var languages: Observable<[String]>
    
    var didSelectLanguage: Observable<String>
    
    var didCancel: Observable<Void>
    
    
    init(githubService: GithubService = GithubService()) {
        self.languages = githubService.getLanguageList()

        let _selectLanguage = PublishSubject<String>()
        self.selectLanguage = _selectLanguage.asObserver()
        self.didSelectLanguage = _selectLanguage.asObservable()

        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()
    }
}
