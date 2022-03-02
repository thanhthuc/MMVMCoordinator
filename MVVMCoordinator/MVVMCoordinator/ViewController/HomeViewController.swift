//
//  HomeViewController.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func gotoGithubAction(_ sender: Any) {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController ?? UINavigationController())
        homeCoordinator.gotoGithubRepo()
    }
    
    
}
