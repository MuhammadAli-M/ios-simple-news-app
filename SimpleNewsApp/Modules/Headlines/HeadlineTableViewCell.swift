//
//  HeadlineTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit
import Kingfisher


protocol HeadlineTableViewCellDelegate: class{
    func cell(urlString: String, updatesFavoriteState isFavorite: Bool)
}

class HeadlineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    static let Id = "HeadlineTableViewCell"
    let favoriteImageString = "heart.fill"
    let notFavoriteImageString = "heart"
    private var isFavorite = false {
        didSet{
            let imageString = isFavorite ? favoriteImageString : notFavoriteImageString
            favoriteImageView.image = UIImage(systemName: imageString)
        }
    }
    var url: String = ""
    weak var delegate: HeadlineTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        isFavorite = false
        setupFavoriteImageView()
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        source.font = UIFont.preferredFont(forTextStyle: .subheadline)
        source.textColor = .systemBlue
        date.textColor = .secondaryLabel
        date.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    fileprivate func setupFavoriteImageView() {
        favoriteImageView.tintColor = .systemRed
        favoriteImageView.contentMode = .scaleAspectFit
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(favoriteBtnTapped)))
        favoriteImageView.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func favoriteBtnTapped(_ sender: Any) {
        isFavorite.toggle()
        delegate?.cell(urlString: self.url, updatesFavoriteState: isFavorite)
    }
}
