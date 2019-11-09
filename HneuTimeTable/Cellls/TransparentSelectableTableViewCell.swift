//
//  TransparentSelectableTableViewCell.swift
//  HneuTimeTable
//
//  Created by Kirill on 27.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class TransparentSelectableTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view  = UIView()
        view.backgroundColor = UIColor.clear
        self.selectedBackgroundView = view
        // Configure the view for the selected state
    }

}
