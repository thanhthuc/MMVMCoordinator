//
//  BaseViewModel.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 02/03/2022.
//

import Foundation
import RxSwift

protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get set }
}
