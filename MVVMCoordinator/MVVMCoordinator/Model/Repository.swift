//
//  Repository.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import Foundation

struct Repository: Codable {
    var fullName: String
    var description: String
    var starCount: Int
    var urlString: String
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description = "description"
        case starCount = "stargazers_count"
        case urlString = "html_url"
    }
}


