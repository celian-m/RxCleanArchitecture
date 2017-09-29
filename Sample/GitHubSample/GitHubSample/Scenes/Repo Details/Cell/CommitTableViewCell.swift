//
//  CommitTableViewCell.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
