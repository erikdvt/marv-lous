//
//  ComicTableViewCellExtension.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/31.
//

import Foundation

extension ComicTableViewCell {
    func convertToHttps(httpURL: String) -> String {
        var httpsURL = httpURL
        let index = httpsURL.index(httpsURL.startIndex, offsetBy: 4)
        
        httpsURL.insert("s", at: index)
        return httpsURL
    }
    
    func buildImageURL(thumbnailPath: String, thumbnailExtension: String) -> String {
        let comicThumbnailURL = String(format: "%@/detail.%@",
                                    convertToHttps(httpURL: thumbnailPath),
                                    thumbnailExtension)
        
        return comicThumbnailURL
    }

}
