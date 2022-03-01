//
//  SessionService.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation
import RxSwift
import RxRelay

class SessionServic: AuthentiationServiceProtocol {
    func signIn() -> Single<SignInResponse> {
        return Single.create { observer in
            observer(.success(SignInResponse.success(token: "12345", userId: "5678")))
            return Disposables.create { }
        }
    }
}
