//
//  RepositoryTableViewCell.swift
//  MVVMCoordinator
//
//  Created by Nguyen Thanh Thuc on 28/02/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var starCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(repository: RepositoryViewModel) {
        
    }
}
