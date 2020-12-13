//
//  HeadlineTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit
import Kingfisher

class HeadlineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
    static let Id = "HeadlineTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        date.text = model.dateString()
        date.textColor = .secondaryLabel
        date.font = UIFont.preferredFont(forTextStyle: .body)
        desc.text = model.desc
    }
    
    func configImage(urlString: String?){
        guard let url = URL(string: urlString ?? "") else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        let processor = DownsamplingImageProcessor(size: headlineImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 7)
        headlineImageView.kf.indicatorType = .activity
        headlineImageView.kf.setImage(
            with: resource,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
            ], completionHandler:
                {
                    result in
                    switch result {
                    case .success(let value):
                        debugLog("image loaded for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        errorLog("image failed: \(error.localizedDescription)")
                    }
                })

    }
}

struct HeadlineCellModel{
    var title: String
    var source: String
    var date: Date
    var dateToString: ((Date) -> (String))
    var desc: String
    var url: String
    var imageUrlString: String?
    
    func dateString() -> String {
        return dateToString(date)
    }
}
