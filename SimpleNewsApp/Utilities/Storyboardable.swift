//
//  Storyboardable.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit

enum StoryboardName:String{
    case Main
}

protocol Storyboardable {
    static var storyboardName: StoryboardName {get}
    static var storyboardId: String {get}
    
    static func instantiateVC() -> Self
}

extension Storyboardable {
    static var storyboardId: String { String(describing: Self.self)}
    
    static func instantiateVC() -> Self {
        let storyboard = UIStoryboard(name: Self.storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(identifier: Self.storyboardId) as! Self
    }
}
