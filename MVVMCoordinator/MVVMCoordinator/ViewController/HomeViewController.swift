//
//  HomeViewController.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var gotoGithubButton: UIButton!
    
    var viewModel: HomeViewModelType!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
    }
    
    private func setupBindings() {
        gotoGithubButton.rx.tap.bind(to: viewModel.gotoGithub).disposed(by: disposeBag)
    }
    
}
