//
//  HeadlinesVC.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//


import UIKit


class HeadlinesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}


extension HeadlinesVC: Storyboardable{
    static var storyboardName: StoryboardName = .Main
}
