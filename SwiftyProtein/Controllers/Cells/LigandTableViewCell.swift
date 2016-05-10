//
//  LigandTableViewCell.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class LigandTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
