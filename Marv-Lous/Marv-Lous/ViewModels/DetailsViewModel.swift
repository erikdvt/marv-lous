//
//  DetailsViewModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/04/21.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func showError(_ error: String)
    func likeComic()
}

class DetailsViewModel {
    
    private weak var delegate: DetailsViewModelDelegate?
    private var singleComic: Comic?
    private var copyrightDisclaimer: String?
    
    init(delegate: DetailsViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func setComicInfo(_ comic: Comic?, _ copyright: String?) {
        singleComic = comic
        copyrightDisclaimer = copyright
    }
    
    func formatComicData() -> FormattedComic {
        
    var formattedComic = FormattedComic()
        
        if let thumbnailPath = singleComic?.thumbnail?.path {
            let thumbnailExtension = singleComic?.thumbnail?.extension ?? "strings"
            formattedComic.thumbnailLink = thumbnailPath.buildImageURL(quality: "detail", imageExtension: thumbnailExtension).convertToHttps
        }
        
        formattedComic.title = singleComic?.title
        formattedComic.variant = singleComic?.variantDescription
        formattedComic.price = String(format: "$%.2f", (singleComic?.prices?[0].price ?? 5.00))
        formattedComic.description = singleComic?.description
        formattedComic.copyright = copyrightDisclaimer
        formattedComic.issue = String(format: "Issue %.0f", (singleComic?.issueNumber ?? 0.0))
        formattedComic.pages = "\(singleComic?.pageCount ?? 0) pages"
        formattedComic.releaseDate = singleComic?.dates?[0].date
        
        return formattedComic
    }
}
