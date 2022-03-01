//
//  LanguageListTableViewCell.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import UIKit

class LanguageListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTitle(language: String) {
        textLabel?.text = language
        selectionStyle = .none
    }
    
}
