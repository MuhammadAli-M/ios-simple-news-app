//
//  HeadlineTableViewCell+HeadlinesCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/21/20.
//

import Foundation
import Kingfisher

extension HeadlineTableViewCell: HeadlinesCell{
    
    func displayTitle(_ titleString: String) {
        title.text = titleString
    }
    
    func displaySource(_ sourceString: String) {
        source.text = sourceString
    }
    
    func displayDate(_ dateString:String) {
        date.text = dateString
    }
    
    func displayDescription(_ descString: String) {
        desc.text = descString
    }
    
    func displayImage(urlString: String?){
        // TODO: fix this to use the urlString without any dates information as it fails caching or think of something
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
