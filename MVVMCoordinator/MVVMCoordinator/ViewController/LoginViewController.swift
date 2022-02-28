//
//  ViewController.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 21/02/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: LoginViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBinding()
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else {
            return
        }
        emailTextfield.rx.text.orEmpty.bind(to: viewModel.emailString).disposed(by: disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to: viewModel.passwordString).disposed(by: disposeBag)
        viewModel.isSigninEnable.bind(to: signInButton.rx.isEnabled).disposed(by: disposeBag)
        signInButton.rx.tap.bind{ viewModel.signInTapped() }.disposed(by: disposeBag)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
    }
    
    
}

