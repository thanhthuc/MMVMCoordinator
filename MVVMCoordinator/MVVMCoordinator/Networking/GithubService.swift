//
//  GithubService.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation

import RxRelay
import RxSwift

enum ServiceError: Error {
    case cannotParse
}

/// A service that knows how to perform requests for GitHub data.
class GithubService {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    /// - Returns: a list of languages from GitHub.
    func getLanguageList() -> Observable<[String]> {
        // For simplicity we will use a stubbed list of languages.
        return Observable.just([
            "Swift",
            "Objective-C",
            "Java",
            "C",
            "C++",
            "Python",
            "C#"
            ])
    }

    /// - Parameter language: Language to filter by
    /// - Returns: A list of most popular repositories filtered by langugage
    func getMostPopulorRepositories(byLanguage language: String) -> Observable<[Repository]> {
        
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: "https://api.github.com/search/repositories?q=language:\(encodedLanguage)&sort=stars")!
        
        return session
            .rx
            .data(request: URLRequest(url: url))
            .flatMap { data -> Observable<[Repository]> in
                do {
                    let item = try JSONDecoder().decode(Items.self, from: data)
                    return Observable.just(item.items)
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
                return Observable.just([])
            }
    }
}
