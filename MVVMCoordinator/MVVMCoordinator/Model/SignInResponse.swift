//
//  SignInResponse.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import Foundation

enum SignInResponse {
    case success(token: String, userId: String)
    case error(message: String)
}
