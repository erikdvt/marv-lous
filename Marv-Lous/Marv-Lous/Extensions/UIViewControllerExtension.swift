//
//  UIViewControllerExtension.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/06.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
