//
//  HeadlineTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var headlineImage: UIImageView!
    
    static let Id = "HeadlineTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headlineImage.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: HeadlineCellModel){
        title.text = model.title
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        source.text = model.source
        source.font = UIFont.preferredFont(forTextStyle: .subheadline)
        source.textColor = .systemBlue
        date.text = model.date
        date.textColor = .secondaryLabel
        date.font = UIFont.preferredFont(forTextStyle: .body)
        desc.text = model.desc
        headlineImage.image = UIImage(named: model.imageName)
    }
}

struct HeadlineCellModel{
    var title: String
    var source: String
    var date: String
    var desc: String
    var imageName: String
}
