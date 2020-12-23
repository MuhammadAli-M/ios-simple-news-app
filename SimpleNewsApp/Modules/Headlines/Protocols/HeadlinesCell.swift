//
//  HeadlinesCell.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/21/20.
//

import Foundation

protocol HeadlinesCell: class {
    var delegate: HeadlineTableViewCellDelegate? {set get}
    func displayTitle(_ titleString: String)
    func displaySource(_ sourceString: String)
    func displayDate(_ dateString:String)
    func displayDescription(_ descString: String)
    func displayImage(urlString: String?)
}
