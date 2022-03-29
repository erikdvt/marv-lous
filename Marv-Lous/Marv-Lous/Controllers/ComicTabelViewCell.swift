//
//  ComicTabelViewCell.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/25.
//

import Foundation
import UIKit

class ComicTableViewCell: UITableViewCell {
    @IBOutlet private var comicImage: UIImageView!
    @IBOutlet private var comicNameLabel: UILabel!
    
    var index = 0
    
    var comics: ComicDataWrapper? {
        didSet {
            updateComics()
        }
    }
    
    func updateComics() {
        guard let thumbnailPath = comics?.data.results[index].thumbnail?.path else { return }
        guard let thumbnailExtension = comics?.data.results[index].thumbnail?.extension else { return }
        guard let comicName = comics?.data.results[index].title else { return }
        
        let comicThumbnail = String(format: "%@/detail.%@",
                                    convertToHttps(httpURL: thumbnailPath),
                                    thumbnailExtension)
        
        comicImage.loadImageFromURL(imageURL: comicThumbnail)
        comicNameLabel.text = comicName
    }
    
    func convertToHttps(httpURL: String) -> String {
        var httpsURL = httpURL
        let index = httpsURL.index(httpsURL.startIndex, offsetBy: 4)
        
        httpsURL.insert("s", at: index)
        return httpsURL
    }
}

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
