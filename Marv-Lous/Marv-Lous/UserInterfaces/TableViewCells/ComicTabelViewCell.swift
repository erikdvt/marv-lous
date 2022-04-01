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
    
    func populateWith(comic: Comic) {
        guard let thumbnailPath = comic.thumbnail?.path else { return }
        guard let thumbnailExtension = comic.thumbnail?.extension else { return }
        guard let comicName = comic.title else { return }
        
        let comicThumbnailURL = thumbnailPath.buildImageURL(quality: "detail", imageExtension: thumbnailExtension).convertToHttps
        
        comicImage.loadImageFromURL(imageURL: comicThumbnailURL)
        comicNameLabel.text = comicName
    }
}
