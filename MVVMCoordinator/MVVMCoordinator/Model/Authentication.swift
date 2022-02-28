//
//  Authentication.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AuthentiationServiceProtocol {
    func signIn() -> Single<SignInResponse>
}


