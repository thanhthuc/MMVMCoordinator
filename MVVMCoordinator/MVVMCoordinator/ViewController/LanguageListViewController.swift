//
//  LanguageListViewController.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class LanguageListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LanguageListViewModelType!
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: String(describing: LanguageListViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = LanguageListViewModel()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "Choose a language"
        tableView.rowHeight = 50
        let nib = UINib(nibName: String(describing: LanguageListTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: LanguageListTableViewCell.self))
    }
    
    private func setupBindings() {
        viewModel.languages
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: LanguageListTableViewCell.self),
                                         cellType: LanguageListTableViewCell.self)) {
                (_, language, cell) in
                
                cell.setupTitle(language: language)
                
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .bind(to: viewModel.selectLanguage)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap.subscribe(onNext: {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
