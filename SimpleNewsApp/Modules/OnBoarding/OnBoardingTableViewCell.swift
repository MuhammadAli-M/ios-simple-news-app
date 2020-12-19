//
//  OnBoardingTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/18/20.
//

import UIKit

class OnBoardingTableViewCell: UITableViewCell {

    static let id = "CategoryTableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.accessoryType = selected ? .checkmark : .none
        self.imageView?.tintColor = .systemBlue
    }
}


extension OnBoardingTableViewCell: OnBoardingCategoryCell{
    func displayName(name: String) {
        textLabel?.text = name
    }
}
