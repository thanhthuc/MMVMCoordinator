//
//  BaseCoordinator.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 01/03/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    /// Coordinator may be have childs or not
    var childCoordinators = [Coordinator]()
    
    /// Coordinator may be have parent or not
    var parentCoordinator: Coordinator?
    
    /// inject a navigation in flow
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// This method use to navigate to destination view
    func start() {
        fatalError("Start method should be override")
    }
    
    /// This method only using for the coordinator have child coordinators
    /// Before child call start, need to: add child coordinator, init parentCoordinator,
    /// then child coordinator call start() implemented
    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    /// In case have child coordinators:
    /// after finish job, need to remove all child coordinator completely from memory
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {$0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }
}


