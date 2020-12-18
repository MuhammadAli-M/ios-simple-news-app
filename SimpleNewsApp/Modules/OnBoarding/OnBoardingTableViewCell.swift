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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension OnBoardingTableViewCell: OnBoardingCategoryCell{
    func displayName(name: String) {
        textLabel?.text = name
    }
}
