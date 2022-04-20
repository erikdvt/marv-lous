//
//  UIImageViewExtension.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/29.
//

import UIKit

extension UIImageView {
    func loadImageFromURL(imageURL: String) {
        let url = URL(string: imageURL)
        guard let url = url else { return }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
