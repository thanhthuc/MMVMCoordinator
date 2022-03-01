//
//  RepositoryList.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import Foundation
import RxSwift
import RxRelay


protocol RepositoryListViewModelType {
    /// Call to update current language. Causes reload of the repositories.
    var setCurrentLanguage: AnyObserver<String> { get set }

    /// Call to show language list screen.
    var chooseLanguage: AnyObserver<Void> { get set }

    /// Call to open repository page.
    var selectRepository: AnyObserver<RepositoryViewModel> { get set }

    /// Call to reload repositories.
    var reload: AnyObserver<Void> { get set }

    // MARK: - Outputs

    /// Emits an array of fetched repositories.
    var repositories: Observable<[RepositoryViewModel]> { get set }

    /// Emits a formatted title for a navigation item.
    var title: Observable<String> { get set }

    /// Emits an error messages to be shown.
    var alertMessage: Observable<String> { get set }

    /// Emits an url of repository page to be shown.
    var showRepository: Observable<URL> { get set }

    /// Emits when we should show language list.
    var showLanguageList: Observable<Void> { get set }
}

class RepositoryListViewModel: RepositoryListViewModelType {
    /// Call to update current language. Causes reload of the repositories.
    var setCurrentLanguage: AnyObserver<String>

    /// Call to show language list screen.
    var chooseLanguage: AnyObserver<Void>

    /// Call to open repository page.
    var selectRepository: AnyObserver<RepositoryViewModel>

    /// Call to reload repositories.
    var reload: AnyObserver<Void>

    // MARK: - Outputs

    /// Emits an array of fetched repositories.
    var repositories: Observable<[RepositoryViewModel]>

    /// Emits a formatted title for a navigation item.
    var title: Observable<String>

    /// Emits an error messages to be shown.
    var alertMessage: Observable<String>

    /// Emits an url of repository page to be shown.
    var showRepository: Observable<URL>

    /// Emits when we should show language list.
    var showLanguageList: Observable<Void>

    init(initialLanguage: String, githubService: GithubService = GithubService()) {

        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()

        let _currentLanguage = BehaviorSubject<String>(value: initialLanguage)
        self.setCurrentLanguage = _currentLanguage.asObserver()

        self.title = _currentLanguage.asObservable()
            .map { "\($0)" }

        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()

        self.repositories = Observable.combineLatest( _reload, _currentLanguage) { _, language in language }
            .flatMapLatest { language in
                githubService.getMostPopulorRepositories(byLanguage: language)
                    .catch { error in
                        _alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                    }
            }
            .map { repositories in repositories.map(RepositoryViewModel.init) }

        let _selectRepository = PublishSubject<RepositoryViewModel>()
        self.selectRepository = _selectRepository.asObserver()
        self.showRepository = _selectRepository.asObservable()
            .map { $0.url }

        let _chooseLanguage = PublishSubject<Void>()
        self.chooseLanguage = _chooseLanguage.asObserver()
        self.showLanguageList = _chooseLanguage.asObservable()
    }
}
