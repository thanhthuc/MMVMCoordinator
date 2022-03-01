//
//  Repository.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import Foundation

struct Items: Codable {
    var items: [Repository]
}

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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        starCount = try container.decodeIfPresent(Int.self, forKey: .starCount) ?? 0
        urlString = try container.decodeIfPresent(String.self, forKey: .urlString) ?? ""
      }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fullName, forKey: .fullName)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(starCount, forKey: .starCount)
        try container.encodeIfPresent(urlString, forKey: .urlString)
    }

}


