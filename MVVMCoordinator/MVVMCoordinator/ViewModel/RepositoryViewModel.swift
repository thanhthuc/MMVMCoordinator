//
//  RepositoryViewModel.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import Foundation

class RepositoryViewModel {
    
    let name: String
    let description: String
    let starCountText: String
    let url: URL
    
    init(repository: Repository) {
        self.name = repository.fullName
        self.description = repository.description
        self.starCountText = "🌟 \(repository.starCount)"
        self.url = URL(string: repository.urlString)!
    }
    
}
