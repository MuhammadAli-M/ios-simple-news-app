//
//  ResuableUI.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
